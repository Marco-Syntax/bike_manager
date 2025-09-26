import 'package:flutter_test/flutter_test.dart';
import 'package:bike_manager/utils/formatting.dart' as fmt;

void main() {
  test('formatDate returns dash for null and formatted date for value', () {
    expect(fmt.formatDate(null), '-');
    expect(fmt.formatDate(DateTime(2023, 3, 5)), '05.03.2023');
  });

  test('formatPrice returns dash for null and formatted price for value', () {
    expect(fmt.formatPrice(null), '-');
    expect(fmt.formatPrice(12.5), '12.50 €');
    expect(fmt.formatPrice(0), '0.00 €');
  });
}
