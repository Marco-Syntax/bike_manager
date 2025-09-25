import 'package:bike_manager/core/bike_repository.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BikeRepository', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('add and getAll', () async {
      final repo = BikeRepository();

      final bike = Bike(
        id: 'a',
        name: 'Repo Bike',
        type: BikeType.mountainbike,
      );

      await repo.add(bike);
      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, equals('a'));
    });

    test('removeById removes the bike', () async {
      final repo = BikeRepository();
      final bike1 = Bike(id: '1', name: 'One', type: BikeType.citybike);
      final bike2 = Bike(id: '2', name: 'Two', type: BikeType.gravel);

      await repo.add(bike1);
      await repo.add(bike2);

      var all = await repo.getAll();
      expect(all, hasLength(2));

      await repo.removeById('1');
      all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, equals('2'));
    });

    test('update replaces existing bike', () async {
      final repo = BikeRepository();
      final bike = Bike(id: 'u', name: 'Old', type: BikeType.other);
      await repo.add(bike);

      final updated = Bike(id: 'u', name: 'New', type: BikeType.other);
      await repo.update(updated);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.name, equals('New'));
    });
  });
}
