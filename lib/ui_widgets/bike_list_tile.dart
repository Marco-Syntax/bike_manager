import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';

class BikeListTile extends StatelessWidget {
  const BikeListTile({super.key, required this.bike, this.onTap});

  final Bike bike;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(bike.name),
      subtitle: Text(formatBikeType(bike.type)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
