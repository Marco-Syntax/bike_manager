import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Bike Manager app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));

  // Use a descendant context where Localizations are available (e.g., Scaffold)
  final ctx = tester.element(find.byType(Scaffold));
    final l10n = AppLocalizations.of(ctx);

    expect(find.text(l10n.appTitle), findsOneWidget);
    expect(find.text(l10n.homePlaceholder), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });
}
