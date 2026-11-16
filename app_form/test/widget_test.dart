import 'package:app_form/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login redirects registered user to dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Migue@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Migue@gmail.com'), findsOneWidget);
  });

  testWidgets('logout redirects to login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Alejo@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Iniciar sesión'), findsOneWidget);
  });

  testWidgets('login rejects invalid credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).first,
      'noexiste@correo.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'incorrecta');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Correo o contraseña incorrectos'), findsOneWidget);
  });
}
