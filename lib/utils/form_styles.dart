import 'package:flutter/material.dart';
import 'package:bike_manager/utils/app_colors.dart';

class FormStyles {
  static const double borderRadius = 12.0;
  static const EdgeInsetsGeometry contentPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 18);

  static InputDecoration filled(BuildContext context, {String? label, String? hint}) {
    final theme = Theme.of(context);
    final fieldFill = theme.colorScheme.surfaceContainerHighest.withAlpha((0.22 * 255).round());
    final labelStyle = TextStyle(color: theme.colorScheme.onSurfaceVariant.withAlpha((0.9 * 255).round()));
    final hintStyle = TextStyle(color: theme.colorScheme.onSurfaceVariant.withAlpha((0.7 * 255).round()));

    return InputDecoration(
      labelText: label,
      labelStyle: labelStyle.copyWith(color: AppColors.darkGreen),
      hintText: hint,
      hintStyle: hintStyle,
      filled: true,
      fillColor: fieldFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),
      contentPadding: contentPadding,
    );
  }

  static TextStyle label(BuildContext context) => TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha((0.9 * 255).round()));
  static TextStyle hint(BuildContext context) => TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha((0.7 * 255).round()));
  static TextStyle input(BuildContext context) => TextStyle(color: Theme.of(context).colorScheme.onSurface);
}
