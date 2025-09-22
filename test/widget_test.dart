import 'package:flutter_test/flutter_test.dart';

import 'package:bike_manager/main.dart';

void main() {
  testWidgets('Bike Manager app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BikeManagerApp());

    expect(find.text('Bike Manager'), findsOneWidget);
    
    expect(find.text('Welcome to Bike Manager'), findsOneWidget);
  });
}
