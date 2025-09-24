import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/core/bike_storage.dart';

final bikeProvider = StateNotifierProvider<BikeViewModel, List<Bike>>(
  (ref) => BikeViewModel()..loadBikes(),
);

class BikeViewModel extends StateNotifier<List<Bike>> {
  final BikeStorage _storage = BikeStorage();

  BikeViewModel() : super([]);

  Future<void> loadBikes() async {
    final bikes = await _storage.loadBikes();
    state = bikes;
  }

  Future<void> addBike(Bike bike) async {
    state = [...state, bike];
    await _storage.saveBikes(state);
  }

  Future<void> removeBike(Bike bike) async {
    state = state.where((b) => b.id != bike.id).toList();
    await _storage.saveBikes(state);
  }

  Future<void> updateBike(Bike oldBike, Bike newBike) async {
    state = state.map((b) => (b.id == oldBike.id) ? newBike : b).toList();
    await _storage.saveBikes(state);
  }

  double? tryParsePrice(String v) {
    final norm = v.replaceAll(',', '.');
    return double.tryParse(norm);
  }

  Future<void> addBikeFromForm({
    required String name,
    required BikeType type,
    String? manufacturer,
    DateTime? purchaseDate,
    String? priceInput,
  }) async {
    final price = (priceInput == null || priceInput.trim().isEmpty)
        ? null
        : tryParsePrice(priceInput.trim());

    final bike = Bike(
      name: name.trim(),
      type: type,
      manufacturer: (manufacturer != null && manufacturer.trim().isNotEmpty)
          ? manufacturer.trim()
          : null,
      purchaseDate: purchaseDate,
      purchasePrice: price,
    );
    await addBike(bike);
  }
}


