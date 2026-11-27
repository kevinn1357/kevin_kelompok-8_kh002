import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('Profile card displays student info and toggles visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Kartu Praktikan'), findsOneWidget);
    expect(find.text('Kevin'), findsOneWidget);
    expect(find.text('NIM: 20240801070'), findsOneWidget);
    expect(find.text('Hobi: Game'), findsOneWidget);
    expect(find.text('Skor Aktivitas: 120'), findsOneWidget);
    expect(find.text('Sembunyikan Profil'), findsOneWidget);

    await tester.tap(find.text('Sembunyikan Profil'));
    await tester.pump();

    expect(find.text('Kartu Praktikan'), findsNothing);
    expect(find.text('Tampilkan Profil'), findsOneWidget);

    await tester.tap(find.text('Tampilkan Profil'));
    await tester.pump();

    expect(find.text('Kartu Praktikan'), findsOneWidget);
    expect(find.text('Sembunyikan Profil'), findsOneWidget);
  });
}
