// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bike.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bike _$BikeFromJson(Map<String, dynamic> json) {
  return _Bike.fromJson(json);
}

/// @nodoc
mixin _$Bike {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  BikeType get type => throw _privateConstructorUsedError;
  String? get manufacturer => throw _privateConstructorUsedError;
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  double? get purchasePrice => throw _privateConstructorUsedError;

  /// Serializes this Bike to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bike
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BikeCopyWith<Bike> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BikeCopyWith<$Res> {
  factory $BikeCopyWith(Bike value, $Res Function(Bike) then) =
      _$BikeCopyWithImpl<$Res, Bike>;
  @useResult
  $Res call({
    String id,
    String name,
    BikeType type,
    String? manufacturer,
    DateTime? purchaseDate,
    double? purchasePrice,
  });
}

/// @nodoc
class _$BikeCopyWithImpl<$Res, $Val extends Bike>
    implements $BikeCopyWith<$Res> {
  _$BikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bike
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? manufacturer = freezed,
    Object? purchaseDate = freezed,
    Object? purchasePrice = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as BikeType,
            manufacturer:
                freezed == manufacturer
                    ? _value.manufacturer
                    : manufacturer // ignore: cast_nullable_to_non_nullable
                        as String?,
            purchaseDate:
                freezed == purchaseDate
                    ? _value.purchaseDate
                    : purchaseDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            purchasePrice:
                freezed == purchasePrice
                    ? _value.purchasePrice
                    : purchasePrice // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BikeImplCopyWith<$Res> implements $BikeCopyWith<$Res> {
  factory _$$BikeImplCopyWith(
    _$BikeImpl value,
    $Res Function(_$BikeImpl) then,
  ) = __$$BikeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    BikeType type,
    String? manufacturer,
    DateTime? purchaseDate,
    double? purchasePrice,
  });
}

/// @nodoc
class __$$BikeImplCopyWithImpl<$Res>
    extends _$BikeCopyWithImpl<$Res, _$BikeImpl>
    implements _$$BikeImplCopyWith<$Res> {
  __$$BikeImplCopyWithImpl(_$BikeImpl _value, $Res Function(_$BikeImpl) _then)
    : super(_value, _then);

  /// Create a copy of Bike
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? manufacturer = freezed,
    Object? purchaseDate = freezed,
    Object? purchasePrice = freezed,
  }) {
    return _then(
      _$BikeImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as BikeType,
        manufacturer:
            freezed == manufacturer
                ? _value.manufacturer
                : manufacturer // ignore: cast_nullable_to_non_nullable
                    as String?,
        purchaseDate:
            freezed == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        purchasePrice:
            freezed == purchasePrice
                ? _value.purchasePrice
                : purchasePrice // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BikeImpl implements _Bike {
  _$BikeImpl({
    required this.id,
    required this.name,
    required this.type,
    this.manufacturer,
    this.purchaseDate,
    this.purchasePrice,
  });

  factory _$BikeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BikeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final BikeType type;
  @override
  final String? manufacturer;
  @override
  final DateTime? purchaseDate;
  @override
  final double? purchasePrice;

  @override
  String toString() {
    return 'Bike(id: $id, name: $name, type: $type, manufacturer: $manufacturer, purchaseDate: $purchaseDate, purchasePrice: $purchasePrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BikeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    manufacturer,
    purchaseDate,
    purchasePrice,
  );

  /// Create a copy of Bike
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BikeImplCopyWith<_$BikeImpl> get copyWith =>
      __$$BikeImplCopyWithImpl<_$BikeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BikeImplToJson(this);
  }
}

abstract class _Bike implements Bike {
  factory _Bike({
    required final String id,
    required final String name,
    required final BikeType type,
    final String? manufacturer,
    final DateTime? purchaseDate,
    final double? purchasePrice,
  }) = _$BikeImpl;

  factory _Bike.fromJson(Map<String, dynamic> json) = _$BikeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  BikeType get type;
  @override
  String? get manufacturer;
  @override
  DateTime? get purchaseDate;
  @override
  double? get purchasePrice;

  /// Create a copy of Bike
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BikeImplCopyWith<_$BikeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
