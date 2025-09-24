import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter/material.dart';

class BikeTypeAvatar extends StatelessWidget {
  const BikeTypeAvatar({
    super.key,
    required this.type,
    this.radius = 20,
    this.iconSize,
    this.backgroundColor,
    this.foregroundColor,
  });

  final BikeType type;
  final double radius;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? bikeTypeBgColor(type, theme);
    final fg = foregroundColor ?? bikeTypeFgColor(type, theme);
    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      child: Icon(bikeTypeIcon(type), color: fg, size: iconSize ?? radius),
    );
  }
}

IconData bikeTypeIcon(BikeType type) {
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

Color bikeTypeBgColor(BikeType type, ThemeData theme) {
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

Color bikeTypeFgColor(BikeType type, ThemeData theme) {
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
