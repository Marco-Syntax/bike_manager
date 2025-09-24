import 'package:bike_manager/models/bike_type.dart';
import 'package:uuid/uuid.dart';

class Bike {
  final String id;
  final String name;
  final BikeType type;
  final String? manufacturer;
  final DateTime? purchaseDate;
  final double? purchasePrice;

  Bike({
    String? id,
    required this.name,
    required this.type,
    this.manufacturer,
    this.purchaseDate,
    this.purchasePrice,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toString(),
      'manufacturer': manufacturer,
      'purchaseDate': purchaseDate?.toIso8601String(),
      'purchasePrice': purchasePrice,
    };
  }

  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      id: json['id'] as String?,
      name: json['name'] as String,
      type: BikeType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => BikeType.values.first,
      ),
      manufacturer: json['manufacturer'] as String?,
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'])
          : null,
      purchasePrice: (json['purchasePrice'] != null)
          ? (json['purchasePrice'] as num).toDouble()
          : null,
    );
  }
}