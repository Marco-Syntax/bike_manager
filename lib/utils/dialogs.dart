import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> confirmDeleteDialog(BuildContext context, String itemName) async {
  final l10n = AppLocalizations.of(context);
  return await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.confirmDeleteTitle),
          content: Text(l10n.confirmDeleteMessage(itemName)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.delete),
            ),
          ],
        ),
      ) ??
      false;
}

void showDeletedSnack(BuildContext context, String itemName) {
  final l10n = AppLocalizations.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(l10n.deletedSnack(itemName))),
  );
}

void showUpdatedSnack(BuildContext context, String fieldLabel) {
  final l10n = AppLocalizations.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(l10n.updatedSnack(fieldLabel))),
  );
}
