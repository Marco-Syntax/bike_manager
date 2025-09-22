import 'package:flutter/material.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:bike_manager/ui_widgets/info_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';

class DetailsView extends ConsumerWidget {
  const DetailsView({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bikeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            tooltip: 'Löschen',
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final deleted = await viewModel.confirmAndDelete(context, bike);
              if (deleted && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InfoRow(label: 'Name', value: bike.name),
          InfoRow(label: 'Typ', value: formatBikeType(bike.type)),
          InfoRow(label: 'Hersteller', value: bike.manufacturer ?? '-'),
          InfoRow(label: 'Kaufdatum', value: formatDate(bike.purchaseDate)),
          InfoRow(label: 'Kaufpreis', value: formatPrice(bike.purchasePrice)),
        ],
      ),
    );
  }
}
