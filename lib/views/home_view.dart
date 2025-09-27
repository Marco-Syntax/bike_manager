import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/views/details_view.dart';
import 'package:bike_manager/widgets/bike_card.dart';
import 'package:bike_manager/views/add_bike_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/dialogs.dart';
import 'package:bike_manager/utils/app_colors.dart';
import 'package:bike_manager/widgets/add_bike_placeholder.dart';
import 'package:bike_manager/widgets/swipe_to_delete_background.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bikeProvider.notifier);
    final bikes = ref.watch(bikeProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = min(constraints.maxHeight * 0.28, 260.0);

          return Column(
            children: [
              SafeArea(
                bottom: false,
                child: Container(
                  width: double.infinity,
                  height: headerHeight,
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
              if (bikes.isEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - headerHeight,
                      ),
                      child: AddBikePlaceholder(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AddBikeView(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 120),
                    itemCount: bikes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final Bike bike = bikes[index];
                      return Dismissible(
                        key: ValueKey(bike.id),
                        direction: DismissDirection.endToStart,
                        background: const SwipeToDeleteBackground(),
                        confirmDismiss: (_) async {
                          final confirmed = await confirmDeleteDialog(
                            context,
                            bike.name,
                          );
                          if (confirmed) {
                            viewModel.removeBike(bike);
                            if (context.mounted) {
                              showDeletedSnack(context, bike.name);
                            }
                          }
                          return confirmed;
                        },
                        onDismissed: (_) {},
                        child: BikeCard(
                          bike: bike,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailsView(bike: bike),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton:
          bikes.isNotEmpty
              ? FloatingActionButton.extended(
                backgroundColor: AppColors.orange,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddBikeView()),
                  );
                },
                icon: const Icon(Icons.add),
                label: Text(l10n.addBike),
              )
              : null,
    );
  }
}
