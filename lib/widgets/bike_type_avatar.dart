import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bike_manager/utils/app_colors.dart';

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
    if (type == BikeType.eBike) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: bg,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.bicycle,
              color: fg,
              size: (iconSize ?? radius) * 0.9,
            ),
            Positioned(
              right: -2,
              top: -2,
              child: FaIcon(
                FontAwesomeIcons.bolt,
                color: AppColors.orange,
                size: (iconSize ?? radius) * 0.5,
              ),
            ),
          ],
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      child: FaIcon(bikeTypeIcon(type), color: fg, size: iconSize ?? radius),
    );
  }
}

IconData bikeTypeIcon(BikeType type) {
  switch (type) {
    case BikeType.mountainbike:
      return FontAwesomeIcons.mountain;
    case BikeType.citybike:
      return FontAwesomeIcons.bicycle;
    case BikeType.trekking:
      return FontAwesomeIcons.route;
    case BikeType.gravel:
      return FontAwesomeIcons.road;
    case BikeType.race:
      return FontAwesomeIcons.personBiking;
    case BikeType.eBike:
      return FontAwesomeIcons.bicycle;
    case BikeType.other:
      return FontAwesomeIcons.bicycle;
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
      return AppColors.accentGravel.withAlpha((0.12 * 255).round());
    case BikeType.race:
      return AppColors.accentRace.withAlpha((0.12 * 255).round());
    case BikeType.eBike:
      return AppColors.accentEBike.withAlpha((0.12 * 255).round());
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
      return AppColors.accentGravel;
    case BikeType.race:
      return AppColors.accentRace;
    case BikeType.eBike:
      return AppColors.accentEBike;
    case BikeType.other:
      return c.onSurface;
  }
}
