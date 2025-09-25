import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:bike_manager/widgets/bike_type_avatar.dart';
import 'package:bike_manager/utils/app_colors.dart';

class BikeCard extends StatefulWidget {
  const BikeCard({
    super.key,
    required this.bike,
    this.onTap,
    this.animate = true,
  });

  final Bike bike;
  final VoidCallback? onTap;
  final bool animate;

  @override
  State<BikeCard> createState() => _BikeCardState();
}

class _BikeCardState extends State<BikeCard> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed == v) return;
    setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double scale = _pressed ? 0.987 : 1.0;
    final double shadowAlpha = _pressed ? 0.16 : 0.10;

    Widget card = AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.orange.withAlpha((0.06 * 255).round()),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mutedGreen.withAlpha(
                (shadowAlpha * 255).round(),
              ),
              blurRadius: _pressed ? 22 : 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashFactory: InkRipple.splashFactory,
            splashColor: AppColors.lightTint.withAlpha((0.30 * 255).round()),
            highlightColor: AppColors.lightTint.withAlpha((0.10 * 255).round()),
            onTapDown: (_) => _setPressed(true),
            onTapUp: (_) => _setPressed(false),
            onTapCancel: () => _setPressed(false),
            onTap: () => widget.onTap?.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mutedGreen.withAlpha(
                            (0.06 * 255).round(),
                          ),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.orange.withAlpha((0.08 * 255).round()),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: BikeTypeAvatar(
                        type: widget.bike.type,
                        radius: 18,
                        iconSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bike.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatBikeType(context, widget.bike.type),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.mutedGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right,
                        color: AppColors.darkGreen.withAlpha(
                          (0.95 * 255).round(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (!widget.animate) return card;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 320),
      builder: (context, t, child) {
        final double slide = 12 * (1 - t);
        return Opacity(
          opacity: t,
          child: Transform.translate(offset: Offset(0, slide), child: child),
        );
      },
      child: card,
    );
  }
}
