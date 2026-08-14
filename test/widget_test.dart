import 'package:flutter_test/flutter_test.dart';
import 'package:healthmanagmentsystem/app/app.dart';

void main() {
  testWidgets('HealthBridge App launches with Login Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthBridgeApp());
    await tester.pumpAndSettle();

    // Verify HealthBridge logo & Login screen title
    expect(find.text('HealthBridge'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
