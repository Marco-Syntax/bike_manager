import 'package:flutter/material.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:bike_manager/ui_widgets/info_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsView extends ConsumerWidget {
  const DetailsView({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final viewModel = ref.read(bikeProvider.notifier);
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detailsTitle),
        actions: [
          IconButton(
            tooltip: l10n.delete,
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
          InfoRow(label: l10n.name, value: bike.name),
          InfoRow(label: l10n.type, value: formatBikeType(context, bike.type)),
          InfoRow(label: l10n.manufacturer, value: bike.manufacturer ?? l10n.notSet),
          InfoRow(label: l10n.purchaseDate, value: formatDate(bike.purchaseDate, notSet: l10n.notSet)),
          InfoRow(label: l10n.purchasePrice, value: formatPrice(bike.purchasePrice, notSet: l10n.notSet)),
        ],
      ),
    );
  }
}
