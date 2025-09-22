import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String formatBikeType(BuildContext context, BikeType type) {
  final l10n = AppLocalizations.of(context);
  switch (type) {
    case BikeType.mountainbike:
      return l10n.bikeTypeMountainbike;
    case BikeType.citybike:
      return l10n.bikeTypeCitybike;
    case BikeType.trekking:
      return l10n.bikeTypeTrekking;
    case BikeType.gravel:
      return l10n.bikeTypeGravel;
    case BikeType.race:
      return l10n.bikeTypeRace;
    case BikeType.eBike:
      return l10n.bikeTypeEBike;
    case BikeType.other:
      return l10n.bikeTypeOther;
  }
}

String formatDate(DateTime? d, {String notSet = '-'}) {
  if (d == null) return notSet;
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  final yyyy = d.year.toString();
  return '$dd.$mm.$yyyy';
}

String formatPrice(double? p, {String notSet = '-'}) {
  if (p == null) return notSet;
  return '${p.toStringAsFixed(2)} €';
}
