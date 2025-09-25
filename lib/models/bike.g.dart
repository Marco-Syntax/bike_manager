// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BikeImpl _$$BikeImplFromJson(Map<String, dynamic> json) => _$BikeImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$BikeTypeEnumMap, json['type']),
  manufacturer: json['manufacturer'] as String?,
  purchaseDate:
      json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$BikeImplToJson(_$BikeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$BikeTypeEnumMap[instance.type]!,
      'manufacturer': instance.manufacturer,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'purchasePrice': instance.purchasePrice,
    };

const _$BikeTypeEnumMap = {
  BikeType.mountainbike: 'mountainbike',
  BikeType.citybike: 'citybike',
  BikeType.trekking: 'trekking',
  BikeType.gravel: 'gravel',
  BikeType.race: 'race',
  BikeType.eBike: 'eBike',
  BikeType.other: 'other',
};
