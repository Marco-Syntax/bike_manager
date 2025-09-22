import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/models/bike.dart';

final bikeProvider = StateNotifierProvider<BikeViewModel, List<Bike>>(
  (ref) => BikeViewModel(),
);

class BikeViewModel extends StateNotifier<List<Bike>> {
  BikeViewModel() : super(const []);

  void addBike(Bike bike) => state = [...state, bike];
  void removeBike(Bike bike) => state = state.where((b) => b != bike).toList();

  Future<bool> confirmAndDelete(BuildContext context, Bike bike) async {
    final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Eintrag löschen?'),
            content: Text('"${bike.name}" wirklich löschen?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Abbrechen'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Löschen'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm) {
      removeBike(bike);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${bike.name}" gelöscht')),
        );
      }
      return true;
    }
    return false;
  }
}

