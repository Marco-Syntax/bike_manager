import 'dart:convert';

import 'package:bike_manager/core/bike_storage.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BikeStorage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('save and load bikes roundtrip', () async {
      final storage = BikeStorage();

      final bikes = [
        Bike(
          id: '1',
          name: 'My Bike',
          type: BikeType.gravel,
          manufacturer: 'Acme',
          purchaseDate: DateTime.utc(2020, 1, 2),
          purchasePrice: 123.45,
        ),
      ];

      await storage.saveBikes(bikes);
      final loaded = await storage.loadBikes();

      expect(loaded, hasLength(1));
      final b = loaded.first;
      expect(b.id, equals('1'));
      expect(b.name, equals('My Bike'));
      expect(b.type, equals(BikeType.gravel));
      expect(b.manufacturer, equals('Acme'));
      expect(b.purchaseDate, equals(DateTime.utc(2020, 1, 2)));
      expect(b.purchasePrice, equals(123.45));
    });

    test('load returns empty list when nothing stored', () async {
      final storage = BikeStorage();
      final loaded = await storage.loadBikes();
      expect(loaded, isEmpty);
    });

    test('supports legacy json shape (null fields)', () async {
      final legacy = [
        {
          'id': '2',
          'name': 'Legacy',
          'type': 'gravel',
          'manufacturer': null,
          'purchaseDate': null,
          'purchasePrice': null,
        },
      ];
      SharedPreferences.setMockInitialValues({'bikes': jsonEncode(legacy)});

      final storage = BikeStorage();
      final loaded = await storage.loadBikes();
      expect(loaded, hasLength(1));
      final b = loaded.first;
      expect(b.id, equals('2'));
      expect(b.manufacturer, isNull);
      expect(b.purchaseDate, isNull);
      expect(b.purchasePrice, isNull);
    });
  });
}
