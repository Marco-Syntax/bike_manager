import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BikeCard extends StatelessWidget {
  const BikeCard({super.key, required this.bike, this.onTap});

  final Bike bike;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PreviewAvatar(type: bike.type),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bike.name,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatBikeType(context, bike.type),
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        if (bike.manufacturer != null && bike.manufacturer!.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            bike.manufacturer!,
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.calendar_today,
                    label: l10n.purchaseDate,
                    value: formatDate(bike.purchaseDate, notSet: l10n.notSet),
                  ),
                  _InfoChip(
                    icon: Icons.euro,
                    label: l10n.purchasePrice,
                    value: formatPrice(bike.purchasePrice, notSet: l10n.notSet),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewAvatar extends StatelessWidget {
  const _PreviewAvatar({required this.type});

  final BikeType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = _previewBgColor(type, theme);
    final fg = _previewFgColor(type, theme);
    final icon = _previewIcon(type);

    return CircleAvatar(
      radius: 20,
      backgroundColor: bg,
      child: Icon(icon, color: fg, size: 20),
    );
  }
}

IconData _previewIcon(BikeType type) {
  switch (type) {
    case BikeType.mountainbike:
      return Icons.terrain;
    case BikeType.citybike:
      return Icons.pedal_bike;
    case BikeType.trekking:
      return Icons.explore;
    case BikeType.gravel:
      return Icons.landscape;
    case BikeType.race:
      return Icons.speed;
    case BikeType.eBike:
      return Icons.electric_bike;
    case BikeType.other:
      return Icons.directions_bike;
  }
}

Color _previewBgColor(BikeType type, ThemeData theme) {
  final c = theme.colorScheme;
  switch (type) {
    case BikeType.mountainbike:
      return c.tertiaryContainer;
    case BikeType.citybike:
      return c.primaryContainer;
    case BikeType.trekking:
      return c.secondaryContainer;
    case BikeType.gravel:
      return c.surfaceContainerHighest;
    case BikeType.race:
      return c.errorContainer;
    case BikeType.eBike:
      return c.inversePrimary;
    case BikeType.other:
      return c.surfaceContainerHighest;
  }
}

Color _previewFgColor(BikeType type, ThemeData theme) {
  final c = theme.colorScheme;
  switch (type) {
    case BikeType.mountainbike:
      return c.onTertiaryContainer;
    case BikeType.citybike:
      return c.onPrimaryContainer;
    case BikeType.trekking:
      return c.onSecondaryContainer;
    case BikeType.gravel:
      return c.onSurfaceVariant;
    case BikeType.race:
      return c.onErrorContainer;
    case BikeType.eBike:
      return c.onPrimary;
    case BikeType.other:
      return c.onSurface;
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall;
    final color = theme.colorScheme.onSurfaceVariant;

    return Container
      (
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: textStyle?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
