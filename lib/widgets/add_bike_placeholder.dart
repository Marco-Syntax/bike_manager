import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/app_colors.dart';

class AddBikePlaceholder extends StatelessWidget {
  const AddBikePlaceholder({super.key, this.onTap});
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
                color: AppColors.darkGreen,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.welcomeSubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.mutedGreen,
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
                    color: AppColors.surface,
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
                color: AppColors.mutedGreen,
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
