import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future<bool> confirmAndDelete(BuildContext context, Bike bike) async {
  final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.confirmDeleteTitle),
            content: Text(l10n.confirmDeleteMessage(bike.name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(l10n.delete),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm) {
      removeBike(bike);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.deletedSnack(bike.name))),
        );
      }
      return true;
    }
    return false;
  }
}

