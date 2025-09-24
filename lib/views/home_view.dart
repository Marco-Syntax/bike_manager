import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/views/details_view.dart';
import 'package:bike_manager/widgets/bike_card.dart';
import 'package:bike_manager/views/add_bike_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/dialogs.dart';
import 'package:bike_manager/utils/app_colors.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikes = ref.watch(bikeProvider);
    final viewModel = ref.read(bikeProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
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
            child:
                bikes.isEmpty
                    ? _AddBikePlaceholder(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AddBikeView(),
                          ),
                        );
                      },
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 120),
                      itemCount: bikes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final Bike bike = bikes[index];
                        return Dismissible(
                          key: ValueKey(bike.id),
                          direction: DismissDirection.endToStart,
                          background: const _DeleteBackground(),
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

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delete, color: Colors.white),
          const SizedBox(width: 8),
          Text(l10n.delete, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _AddBikePlaceholder extends StatelessWidget {
  const _AddBikePlaceholder({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 44.0,
          left: 28.0,
          right: 28.0,
          bottom: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.welcomeMessage,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.welcomeSubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(36),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.orange,
                      style: BorderStyle.solid,
                      width: 3.5,
                    ),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 60,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              l10n.addBike,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
