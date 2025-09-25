import 'package:bike_manager/main.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter/material.dart';
import 'package:bike_manager/widgets/bike_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('can add a bike via the form and see it in the list', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));

    final ctx = tester.element(find.byType(Scaffold));
    final l10n = AppLocalizations.of(ctx);

    expect(find.text(l10n.welcomeMessage), findsOneWidget);
    expect(find.byType(BikeCard), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text(l10n.addBike), findsOneWidget);

    // Fill required fields: Name and Typ
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.name),
      'Test Bike',
    );

    // Open the dropdown for type and select an entry
    await tester.tap(find.byType(DropdownButtonFormField<BikeType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.bikeTypeGravel).last);
    await tester.pumpAndSettle();

    // Save
    await tester.tap(find.text(l10n.save));
    await tester.pumpAndSettle();

    // Back on the list: placeholder gone, new bike visible
    expect(find.text(l10n.homePlaceholder), findsNothing);
    expect(find.text('Test Bike'), findsOneWidget);
    expect(find.byType(BikeCard), findsOneWidget);
  });
}
