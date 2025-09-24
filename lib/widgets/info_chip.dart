import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.spacing = 6,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.borderRadius,
  });

  final IconData icon;
  final String label;
  final String value;

  final double iconSize;
  final EdgeInsets padding;
  final double spacing;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = foregroundColor ?? theme.colorScheme.onSurfaceVariant;
    final chipTextStyle =
        textStyle ?? theme.textTheme.bodySmall?.copyWith(color: color);
    final bg =
        backgroundColor ??
        theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: borderRadius ?? BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: color),
          SizedBox(width: spacing),
          Text('$label: $value', style: chipTextStyle),
        ],
      ),
    );
  }
}
