import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/core/bike_repository.dart';
import 'package:uuid/uuid.dart';

final bikeProvider = StateNotifierProvider<BikeViewModel, List<Bike>>(
  (ref) =>
      BikeViewModel(repository: ref.read(bikeRepositoryProvider))..loadBikes(),
);

class BikeViewModel extends StateNotifier<List<Bike>> {
  final BikeRepository _repository;

  BikeViewModel({BikeRepository? repository})
    : _repository = repository ?? BikeRepository(),
      super([]);

  Future<void> loadBikes() async {
    final bikes = await _repository.getAllBikes();
    state = bikes;
  }

  Future<void> addBike(Bike bike) async {
    await _repository.addBike(bike);
    await loadBikes();
  }

  Future<void> removeBike(Bike bike) async {
    await _repository.removeBikeById(bike.id);
    await loadBikes();
  }

  Future<void> updateBike(Bike oldBike, Bike newBike) async {
    await _repository.updateBike(newBike);
    await loadBikes();
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
    final price =
        (priceInput == null || priceInput.trim().isEmpty)
            ? null
            : tryParsePrice(priceInput.trim());

    final bike = Bike(
      id: const Uuid().v4(),
      name: name.trim(),
      type: type,
      manufacturer:
          (manufacturer != null && manufacturer.trim().isNotEmpty)
              ? manufacturer.trim()
              : null,
      purchaseDate: purchaseDate,
      purchasePrice: price,
    );
    await addBike(bike);
  }
}
