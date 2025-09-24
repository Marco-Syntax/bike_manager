import 'package:bike_manager/core/bike_storage.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bikeRepositoryProvider = Provider<BikeRepository>(
  (ref) => BikeRepository(),
);

class BikeRepository {
  final BikeStorage _storage = BikeStorage();

  Future<List<Bike>> getAll() async {
    return await _storage.loadBikes();
  }

  Future<void> add(Bike bike) async {
    final bikes = await _storage.loadBikes();
    bikes.add(bike);
    await _storage.saveBikes(bikes);
  }

  Future<void> removeById(String id) async {
    final bikes = await _storage.loadBikes();
    final updated = bikes.where((b) => b.id != id).toList();
    await _storage.saveBikes(updated);
  }

  Future<void> update(Bike newBike) async {
    final bikes = await _storage.loadBikes();
    final updated = bikes.map((b) => b.id == newBike.id ? newBike : b).toList();
    await _storage.saveBikes(updated);
  }
}
