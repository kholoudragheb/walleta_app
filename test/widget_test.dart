import 'package:flutter_test/flutter_test.dart';
import 'package:walleta_app/main.dart';

void main() {
  testWidgets('WalletaApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WalletaApp());
    expect(find.text('Walleta'), findsOneWidget);
  });
}
