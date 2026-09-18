import 'package:flutter_test/flutter_test.dart';

import 'package:mbahe_solidarite/main.dart';

void main() {
  testWidgets("La page d'accueil affiche le titre du site", (WidgetTester tester) async {
    await tester.pumpWidget(const MbaheApp());
    await tester.pumpAndSettle();

    expect(find.text("M'bahé Solidarité"), findsWidgets);
  });
}
