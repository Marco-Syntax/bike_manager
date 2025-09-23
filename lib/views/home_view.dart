import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/views/details_view.dart';
import 'package:bike_manager/ui_widgets/bike_card.dart';
import 'package:bike_manager/views/add_bike_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/dialogs.dart';


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
            child: bikes.isEmpty
                ? _AddBikePlaceholder(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AddBikeView()),
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
                        key: ObjectKey(bike),
                        direction: DismissDirection.endToStart,
                        background: const _DeleteBackground(),
                        confirmDismiss: (_) async {
                          final confirmed = await confirmDeleteDialog(context, bike.name);
                          if (confirmed) {
                            viewModel.removeBike(bike);
                            if (context.mounted) showDeletedSnack(context, bike.name);
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
      floatingActionButton: bikes.isNotEmpty
          ? FloatingActionButton.extended(
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
      color: Colors.red,
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.welcomeMessage,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFFF9800),
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Icon(Icons.add, size: 56, color: const Color.fromARGB(255, 2, 88, 83)),
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
