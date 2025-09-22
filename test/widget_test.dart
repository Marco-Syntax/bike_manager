import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/main.dart';

void main() {
  testWidgets('Bike Manager app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));

    expect(find.text('Fahrradverwaltung'), findsOneWidget);
    expect(find.text('Bitte fügen Sie Ihr Fahrrad hinzu'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });
}
