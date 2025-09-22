import 'package:bike_manager/main.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('can add a bike via the form and see it in the list', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));

    // Initially, the placeholder should be visible and no list items present
    expect(find.text('Bitte fügen Sie Ihr Fahrrad hinzu'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    // Open the add-bike screen via FAB
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Fahrrad hinzufügen'), findsOneWidget);

    // Fill required fields: Name and Typ
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name'),
      'Test Bike',
    );

    // Open the dropdown for type and select an entry
    await tester.tap(find.byType(DropdownButtonFormField<BikeType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gravel').last);
    await tester.pumpAndSettle();

    // Save
    await tester.tap(find.text('Speichern'));
    await tester.pumpAndSettle();

    // Back on the list: placeholder gone, new bike visible
    expect(find.text('Bitte fügen Sie Ihr Fahrrad hinzu'), findsNothing);
    expect(find.text('Test Bike'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
