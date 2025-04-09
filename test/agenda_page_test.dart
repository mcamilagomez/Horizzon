import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/ui/pages/agenda.dart';

void main() {
  group('AgendaPage Tests', () {
    testWidgets('Muestra la estructura básica de la agenda', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AgendaPage()));

      expect(find.text('Agenda'), findsOneWidget);
      expect(find.text("'Un nuevo evento en el horizonte'"), findsOneWidget);
      expect(find.text('Recordatorios'), findsOneWidget);
    });

    testWidgets('Cambia de mes correctamente', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AgendaPage()));

      final currentMonth = find.byType(Text).at(2); // El texto del mes actual
      final initialMonth = tester.widget<Text>(currentMonth).data;

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pump();

      final newMonth = tester.widget<Text>(currentMonth).data;
      expect(newMonth, isNot(equals(initialMonth)));
    });

    testWidgets('Selecciona un día correctamente', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AgendaPage()));

      // Encuentra el primer día del mes
      final firstDay = find.text('1');
      await tester.tap(firstDay);
      await tester.pump();

      expect(find.text('Seleccionado:'), findsOneWidget);
    });

    testWidgets('Scroll horizontal de días funciona', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AgendaPage()));

      final scrollable = find.byType(ListView).first;
      await tester.fling(scrollable, const Offset(-300, 0), 300);
      await tester.pumpAndSettle();

      // Verifica que el scroll ha ocurrido
      expect(find.text('15'), findsOneWidget); // Asumiendo que el día 15 es visible
    });
  });
}