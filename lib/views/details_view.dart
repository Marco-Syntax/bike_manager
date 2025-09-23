import 'package:flutter/material.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/dialogs.dart';
import 'package:bike_manager/ui_widgets/bike_details_card.dart';

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
              final confirmed = await confirmDeleteDialog(context, bike.name);
              if (confirmed) {
                viewModel.removeBike(bike);
                if (context.mounted) showDeletedSnack(context, bike.name);
                if (context.mounted) Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BikeDetailsCard(bike: bike),
        ],
      ),
    );
  }
}
