import 'package:bike_manager/models/bike_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bike.freezed.dart';
part 'bike.g.dart';

@freezed
class Bike with _$Bike {
  factory Bike({
    required String id,
    required String name,
    required BikeType type,
    String? manufacturer,
    DateTime? purchaseDate,
    double? purchasePrice,
  }) = _Bike;

  factory Bike.fromJson(Map<String, dynamic> json) => _$BikeFromJson(json);
}
