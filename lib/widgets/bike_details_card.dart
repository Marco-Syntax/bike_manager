import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/widgets/bike_type_avatar.dart';
import 'package:bike_manager/widgets/info_chip.dart';
import 'package:bike_manager/utils/dialogs.dart';


class BikeDetailsCard extends ConsumerWidget {
  const BikeDetailsCard({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bikeProvider.notifier);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 4),
                BikeTypeAvatar(type: bike.type, radius: 34, iconSize: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike.name,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatBikeType(context, bike.type),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _EditableDetailRow(
              icon: Icons.precision_manufacturing,
              label: l10n.manufacturer,
              value: bike.manufacturer?.trim().isNotEmpty == true
                  ? bike.manufacturer!.trim()
                  : l10n.notSet,
              onEdit: () async {
                final controller = TextEditingController(text: bike.manufacturer ?? '');
                final result = await showDialog<String?>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.optionalManufacturer),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: l10n.manufacturer),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(null),
                        child: Text(l10n.cancel),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
                        child: Text(l10n.save),
                      ),
                    ],
                  ),
                );
                if (result == null) return;
                final newManufacturer = result.isEmpty ? null : result;
                final updated = Bike(
                  id: bike.id,
                  name: bike.name,
                  type: bike.type,
                  manufacturer: newManufacturer,
                  purchaseDate: bike.purchaseDate,
                  purchasePrice: bike.purchasePrice,
                );
                await viewModel.updateBike(bike, updated);
                if (context.mounted) showUpdatedSnack(context, l10n.manufacturer);
              },
            ),
            const SizedBox(height: 8),
            _EditableDetailRow(
              icon: Icons.calendar_today,
              label: l10n.purchaseDate,
              value: formatDate(bike.purchaseDate, notSet: l10n.notSet),
              onEdit: () async {
                final now = DateTime.now();
                final initial = bike.purchaseDate ?? now;
                final picked = await showDatePicker(
                  context: context,
                  initialDate: initial,
                  firstDate: DateTime(1970),
                  lastDate: DateTime(now.year + 5),
                );
                if (picked == null) return;
                final updated = Bike(
                  id: bike.id,
                  name: bike.name,
                  type: bike.type,
                  manufacturer: bike.manufacturer,
                  purchaseDate: picked,
                  purchasePrice: bike.purchasePrice,
                );
                await viewModel.updateBike(bike, updated);
                if (context.mounted) showUpdatedSnack(context, l10n.purchaseDate);
              },
            ),
            const SizedBox(height: 8),
            _EditableDetailRow(
              icon: Icons.euro,
              label: l10n.purchasePrice,
              value: formatPrice(bike.purchasePrice, notSet: l10n.notSet),
              onEdit: () async {
                final controller = TextEditingController(
                    text: bike.purchasePrice != null ? bike.purchasePrice.toString() : '');
                String? errorText;

                final result = await showDialog<String?>(
                  context: context,
                  builder: (ctx) => StatefulBuilder(builder: (ctx2, setState) {
                    void validate(String v) {
                      final trimmed = v.trim();
                      if (trimmed.isEmpty) {
                        setState(() => errorText = null);
                        return;
                      }
                      final parsed = viewModel.tryParsePrice(trimmed);
                      if (parsed == null) {
                        setState(() => errorText = l10n.invalidPrice);
                      } else if (parsed < 0) {
                        setState(() => errorText = l10n.negativePrice);
                      } else {
                        setState(() => errorText = null);
                      }
                    }
                    validate(controller.text);
                    return AlertDialog(
                      title: Text(l10n.optionalPurchasePrice),
                      content: TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.priceHint,
                          errorText: errorText,
                        ),
                        onChanged: validate,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(null),
                          child: Text(l10n.cancel),
                        ),
                        FilledButton(
                          onPressed: errorText == null
                              ? () => Navigator.of(ctx).pop(controller.text.trim())
                              : null,
                          child: Text(l10n.save),
                        ),
                      ],
                    );
                  }),
                );

                if (result == null) return;
                final priceInput = result.trim();
                final price = priceInput.isEmpty ? null : viewModel.tryParsePrice(priceInput);
                final updated = Bike(
                  id: bike.id,
                  name: bike.name,
                  type: bike.type,
                  manufacturer: bike.manufacturer,
                  purchaseDate: bike.purchaseDate,
                  purchasePrice: price,
                );
                await viewModel.updateBike(bike, updated);
                if (context.mounted) showUpdatedSnack(context, l10n.purchasePrice);
              },
            ),

            const SizedBox(height: 12),
            const Divider(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                InfoChip(
                  icon: Icons.pedal_bike,
                  label: l10n.type,
                  value: formatBikeType(context, bike.type),
                ),
                InfoChip(
                  icon: Icons.calendar_today,
                  label: l10n.purchaseDate,
                  value: formatDate(bike.purchaseDate, notSet: l10n.notSet),
                ),
                InfoChip(
                  icon: Icons.euro,
                  label: l10n.purchasePrice,
                  value: formatPrice(bike.purchasePrice, notSet: l10n.notSet),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class _EditableDetailRow extends StatelessWidget {
  const _EditableDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: 20),
          color: theme.colorScheme.primary,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          onPressed: onEdit,
        ),
      ],
    );
  }
}


