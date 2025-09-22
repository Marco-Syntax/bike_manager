import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/views/details_view.dart';
import 'package:bike_manager/ui_widgets/bike_list_tile.dart';
import 'package:bike_manager/views/add_bike_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikes = ref.watch(bikeProvider);
    final viewModel = ref.read(bikeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrradverwaltung'),
      ),
      body: bikes.isEmpty
          ? const _EmptyPlaceholder()
          : ListView.separated(
              itemCount: bikes.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final Bike bike = bikes[index];
                return Dismissible(
                  key: ObjectKey(bike),
                  direction: DismissDirection.endToStart,
                  background: const _DeleteBackground(),
          confirmDismiss: (_) => viewModel.confirmAndDelete(context, bike),
                  onDismissed: (_) {},
                  child: BikeListTile(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddBikeView()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Fahrrad hinzufügen'),
      ),
    );
  }

}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete, color: Colors.white),
          SizedBox(width: 8),
          Text('Löschen', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pedal_bike, size: 56, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'Bitte fügen Sie Ihr Fahrrad hinzu',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
