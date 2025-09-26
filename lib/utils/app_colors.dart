import 'package:flutter/material.dart';
import 'package:bike_manager/models/bike_type.dart';

class AppColors {
  static const Color orange = Color(0xFFFF7A18);
  static const Color darkGreen = Color(0xFF225E50);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF7F7F9);

  static const Color textPrimary = Color(0xFF4A4A4A);
  static const Color textSecondary = Color(0xFF6E6E6E);
  static const Color mutedGreen = Color(0xFF58786C);
  static const Color lightTint = Color(0xFFF3F7F4);
  static const Color accentRace = Color(0xFFB00020);
  static const Color accentEBike = Color(0xFF2B7BE4);
  static const Color accentGravel = Color(0xFF9EA3A8);

  static const Color cardGradientStart = Color(0xFFD2F0E6);
  static const Color cardGradientEnd = Color(0xFFFFFFFF);

  static const Color cityStart = Color(0xFFE8FBFA);
  static const Color cityEnd = Color(0xFFD6F3F0);

  static const Color mountainStart = Color(0xFFF2FFF6);
  static const Color mountainEnd = Color(0xFFDFF7EA);

  static const Color raceStart = Color(0xFFFFF2EC);
  static const Color raceEnd = Color(0xFFFFD7C6);

  static const Color trekkingStart = Color(0xFFFFFBEE);
  static const Color trekkingEnd = Color(0xFFFFF0D9);

  static const Color gravelStart = Color(0xFFF7F5F2);
  static const Color gravelEnd = Color(0xFFE6E1DC);

  static const Color eBikeStart = Color(0xFFEFF6FF);
  static const Color eBikeEnd = Color(0xFFD6EDFF);

  static const Color otherStart = Color(0xFFF6EEF9);
  static const Color otherEnd = Color(0xFFEEDFF6);

  static LinearGradient gradientForBikeType(BikeType type) {
    switch (type) {
      case BikeType.citybike:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cityStart, cityEnd],
        );
      case BikeType.mountainbike:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [mountainStart, mountainEnd],
        );
      case BikeType.race:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [raceStart, raceEnd],
        );
      case BikeType.trekking:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [trekkingStart, trekkingEnd],
        );
      case BikeType.gravel:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gravelStart, gravelEnd],
        );
      case BikeType.eBike:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [eBikeStart, eBikeEnd],
        );
      case BikeType.other:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [otherStart, otherEnd],
        );
    }
  }

  // single color fallback per bike type
  static Color colorForBikeType(BikeType type) {
    switch (type) {
      case BikeType.citybike:
        return cityStart;
      case BikeType.mountainbike:
        return mountainStart;
      case BikeType.race:
        return raceStart;
      case BikeType.trekking:
        return trekkingStart;
      case BikeType.gravel:
        return gravelStart;
      case BikeType.eBike:
        return eBikeStart;
      case BikeType.other:
        return otherStart;
    }
  }
}
