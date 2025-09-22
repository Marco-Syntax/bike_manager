import 'package:bike_manager/models/bike_type.dart';

String formatBikeType(BikeType type) {
  const labels = {
    BikeType.mountainbike: 'Mountainbike',
    BikeType.citybike: 'Citybike',
    BikeType.trekking: 'Trekking',
    BikeType.gravel: 'Gravel',
    BikeType.race: 'Rennrad',
    BikeType.eBike: 'E-Bike',
    BikeType.other: 'Sonstiges',
  };
  return labels[type] ?? 'Unbekannt';
}

String formatDate(DateTime? d) {
  if (d == null) return '-';
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  final yyyy = d.year.toString();
  return '$dd.$mm.$yyyy';
}

String formatPrice(double? p) {
  if (p == null) return '-';
  return '${p.toStringAsFixed(2)} €';
}
