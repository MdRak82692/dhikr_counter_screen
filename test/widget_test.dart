import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dhikr_counter_screen/app.dart';

void main() {
  testWidgets('Dhikr counter smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: DhikrCounterApp()));

    // Verify that our dhikr starts at its initial mock value 24.
    expect(find.text('24'), findsOneWidget);
  });
}
