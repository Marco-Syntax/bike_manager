import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/ui_widgets/bike_type_avatar.dart';
import 'package:bike_manager/ui_widgets/info_chip.dart';


class BikeDetailsCard extends StatelessWidget {
  const BikeDetailsCard({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 2),
                BikeTypeAvatar(type: bike.type, radius: 26, iconSize: 26),
                const SizedBox(width: 14),
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
            _DetailRow(
              icon: Icons.precision_manufacturing,
              label: l10n.manufacturer,
              value: bike.manufacturer?.trim().isNotEmpty == true
                  ? bike.manufacturer!.trim()
                  : l10n.notSet,
            ),
            const SizedBox(height: 8),
            _DetailRow(
              icon: Icons.calendar_today,
              label: l10n.purchaseDate,
              value: formatDate(bike.purchaseDate, notSet: l10n.notSet),
            ),
            const SizedBox(height: 8),
            _DetailRow(
              icon: Icons.euro,
              label: l10n.purchasePrice,
              value: formatPrice(bike.purchasePrice, notSet: l10n.notSet),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(color: color),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


