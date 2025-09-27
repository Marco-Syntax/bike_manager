import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/app_colors.dart';

class SwipeToDeleteBackground extends StatelessWidget {
  const SwipeToDeleteBackground({super.key});

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
