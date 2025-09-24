import 'package:flutter/material.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/dialogs.dart';
import 'package:bike_manager/widgets/bike_details_card.dart';
import 'package:bike_manager/utils/app_colors.dart';

class DetailsView extends ConsumerWidget {
  const DetailsView({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bikeProvider.notifier);
    final l10n = AppLocalizations.of(context);
    final bikes = ref.watch(bikeProvider);
    final currentBike = bikes.firstWhere(
      (b) => b.id == bike.id,
      orElse: () => bike,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detailsTitle),
        actions: [
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete, color: AppColors.orange),
            onPressed: () async {
              final confirmed = await confirmDeleteDialog(
                context,
                currentBike.name,
              );
              if (confirmed) {
                viewModel.removeBike(currentBike);
                if (context.mounted) {
                  showDeletedSnack(context, currentBike.name);
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [BikeDetailsCard(bike: currentBike)],
            ),
          ),
        ],
      ),
    );
  }
}
