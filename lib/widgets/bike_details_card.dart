import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/widgets/bike_type_avatar.dart';
import 'package:bike_manager/utils/app_colors.dart';
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: AppColors.gradientForBikeType(bike.type),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.orange.withAlpha((0.04 * 255).round()),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mutedGreen.withAlpha((0.06 * 255).round()),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
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
                      Text(bike.name, style: theme.textTheme.titleLarge),
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
              value:
                  bike.manufacturer?.trim().isNotEmpty == true
                      ? bike.manufacturer!.trim()
                      : l10n.notSet,
              onEdit: () async {
                final result = await showEditTextDialog(
                  context: context,
                  title: l10n.optionalManufacturer,
                  initialText: bike.manufacturer ?? '',
                  hint: l10n.manufacturer,
                  saveLabel: l10n.save,
                  cancelLabel: l10n.cancel,
                );
                if (result == null) return;
                final newManufacturer = result.isEmpty ? null : result;
                final updated = bike.copyWith(manufacturer: newManufacturer);
                await viewModel.updateBike(bike, updated);
                if (context.mounted) {
                  showUpdatedSnack(context, l10n.manufacturer);
                }
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
                final updated = bike.copyWith(purchaseDate: picked);
                await viewModel.updateBike(bike, updated);
                if (context.mounted) {
                  showUpdatedSnack(context, l10n.purchaseDate);
                }
              },
            ),
            const SizedBox(height: 8),
            _EditableDetailRow(
              icon: Icons.euro,
              label: l10n.purchasePrice,
              value: formatPrice(bike.purchasePrice, notSet: l10n.notSet),
              onEdit: () async {
                final result = await showEditTextDialog(
                  context: context,
                  title: l10n.optionalPurchasePrice,
                  initialText:
                      bike.purchasePrice != null
                          ? bike.purchasePrice.toString()
                          : '',
                  hint: l10n.priceHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  validator: (v) {
                    final trimmed = v.trim();
                    if (trimmed.isEmpty) return null;
                    final parsed = viewModel.tryParsePrice(trimmed);
                    if (parsed == null) return l10n.invalidPrice;
                    if (parsed < 0) return l10n.negativePrice;
                    return null;
                  },
                  saveLabel: l10n.save,
                  cancelLabel: l10n.cancel,
                );

                if (result == null) return;
                final priceInput = result.trim();
                final price =
                    priceInput.isEmpty
                        ? null
                        : viewModel.tryParsePrice(priceInput);
                final updated = bike.copyWith(purchasePrice: price);
                await viewModel.updateBike(bike, updated);
                if (context.mounted) {
                  showUpdatedSnack(context, l10n.purchasePrice);
                }
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
            ),
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
