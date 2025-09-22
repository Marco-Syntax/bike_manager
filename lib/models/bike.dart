import 'package:bike_manager/models/bike_type.dart';

class Bike {
  final String name;
  final BikeType type;
  final String? manufacturer;
  final DateTime? purchaseDate;
  final double? purchasePrice;

  Bike({
    required this.name,
    required this.type,
    this.manufacturer,
    this.purchaseDate,
    this.purchasePrice,
  });
}