import 'package:flutter/material.dart';
import 'package:bike_manager/utils/app_colors.dart';

class ButtonStyles {
  static TextStyle get dialogCancelTextStyle =>
      const TextStyle(color: AppColors.darkGreen);

  static ButtonStyle primaryFilled({double radius = 12}) {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
