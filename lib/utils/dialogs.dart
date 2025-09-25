import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_manager/utils/button_styles.dart';
import 'package:bike_manager/utils/form_styles.dart';

Future<bool> confirmDeleteDialog(BuildContext context, String itemName) async {
  final l10n = AppLocalizations.of(context);
  return await showConfirmDialog(
    context: context,
    title: l10n.confirmDeleteTitle,
    content: l10n.confirmDeleteMessage(itemName),
    confirmLabel: l10n.delete,
    cancelLabel: l10n.cancel,
    confirmStyle: ButtonStyles.primaryFilled(),
  );
}

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? confirmLabel,
  String? cancelLabel,
  ButtonStyle? confirmStyle,
}) async {
  return await showDialog<bool>(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text(
                    cancelLabel ?? 'Cancel',
                    style: ButtonStyles.dialogCancelTextStyle,
                  ),
                ),
                FilledButton(
                  style: confirmStyle,
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text(confirmLabel ?? 'Confirm'),
                ),
              ],
            ),
      ) ??
      false;
}

void showDeletedSnack(BuildContext context, String itemName) {
  final l10n = AppLocalizations.of(context);
  showAppSnack(
    context,
    l10n.deletedSnack(itemName),
    type: ContentType.success,
    title: l10n.deletedTitle,
  );
}

void showUpdatedSnack(BuildContext context, String fieldLabel) {
  final l10n = AppLocalizations.of(context);
  showAppSnack(
    context,
    fieldLabel,
    type: ContentType.success,
    title: l10n.updatedTitle,
  );
}

void showAppSnack(
  BuildContext context,
  String message, {
  Duration duration = const Duration(milliseconds: 1500),
  ContentType type = ContentType.success,
  String? title,
}) {
  final defaultTitle = title ?? '';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: duration,
      content: AwesomeSnackbarContent(
        title: defaultTitle,
        message: message,
        contentType: type,
      ),
    ),
  );
}

Future<String?> showEditTextDialog({
  required BuildContext context,
  required String title,
  String? initialText,
  String? hint,
  TextInputType? keyboardType,
  String? Function(String value)? validator,
  String? saveLabel,
  String? cancelLabel,
}) async {
  final controller = TextEditingController(text: initialText ?? '');
  String? errorText;

  final result = await showDialog<String?>(
    context: context,
    builder:
        (ctx) => StatefulBuilder(
          builder: (ctx2, setState) {
            void validate(String v) {
              if (validator == null) {
                setState(() => errorText = null);
                return;
              }
              final err = validator(v);
              setState(() => errorText = err);
            }

            validate(controller.text);

            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: FormStyles.filled(
                  ctx2,
                  hint: hint,
                ).copyWith(errorText: errorText),
                style: FormStyles.input(ctx2),
                onChanged: validate,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx2).pop(null),
                  child: Text(
                    cancelLabel ?? 'Cancel',
                    style: ButtonStyles.dialogCancelTextStyle,
                  ),
                ),
                FilledButton(
                  style: ButtonStyles.primaryFilled(),
                  onPressed:
                      errorText == null
                          ? () => Navigator.of(ctx2).pop(controller.text.trim())
                          : null,
                  child: Text(saveLabel ?? 'Save'),
                ),
              ],
            );
          },
        ),
  );

  return result;
}
