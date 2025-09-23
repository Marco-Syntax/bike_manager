import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';

final bikeProvider = StateNotifierProvider<BikeViewModel, List<Bike>>(
  (ref) => BikeViewModel(),
);

class BikeViewModel extends StateNotifier<List<Bike>> {
  BikeViewModel() : super(const []);

  void addBike(Bike bike) => state = [...state, bike];
  void removeBike(Bike bike) => state = state.where((b) => b != bike).toList();

  double? tryParsePrice(String v) {
    final norm = v.replaceAll(',', '.');
    return double.tryParse(norm);
  }

  void addBikeFromForm({
    required String name,
    required BikeType type,
    String? manufacturer,
    DateTime? purchaseDate,
    String? priceInput,
  }) {
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
    addBike(bike);
  }

}

