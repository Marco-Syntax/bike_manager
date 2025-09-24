import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:bike_manager/widgets/bike_type_avatar.dart';

class BikeCard extends StatelessWidget {
  const BikeCard({super.key, required this.bike, this.onTap});

  final Bike bike;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BikeTypeAvatar(type: bike.type, radius: 20, iconSize: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bike.name, style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          formatBikeType(context, bike.type),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
