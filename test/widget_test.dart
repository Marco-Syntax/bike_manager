import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bike_manager/widgets/bike_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Bike Manager app smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));

    final ctx = tester.element(find.byType(Scaffold));
    final l10n = AppLocalizations.of(ctx);
    expect(find.text(l10n.welcomeMessage), findsOneWidget);
    expect(find.byType(BikeCard), findsNothing);
  });
}
