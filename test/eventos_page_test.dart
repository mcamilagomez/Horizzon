import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';

import 'package:provider/provider.dart';
import 'package:horizzon/ui/pages/eventos.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';

void main() {
  late User mockUser;
  late EventController mockEventController;

  setUp(() {
    mockUser = User(hash: 'user123', myEvents: []);
    mockEventController = EventController(user: mockUser);
  });

  Widget createEventosPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventController>.value(
            value: mockEventController),
      ],
      child: MaterialApp(
        home: EventosPage(user: mockUser),
      ),
    );
  }

  group('EventosPage Widget Tests', () {
    testWidgets('Debe mostrar el título principal correctamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventosPage());
      expect(find.text("Líneas de Eventos"), findsOneWidget);
      expect(find.text("Horizzon"), findsOneWidget);
      expect(find.text("Todos los eventos"), findsOneWidget);
    });

    testWidgets('Debe mostrar las líneas de eventos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventosPage());
      await tester.pumpAndSettle();
      final master = Master.createWithSampleData();
      for (var track in master.eventTracks) {
        expect(find.text(track.name), findsOneWidget);
        expect(find.text(track.description), findsOneWidget);
      }
    });

    testWidgets('Debe mostrar los primeros dos eventos de cada track',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventosPage());
      await tester.pumpAndSettle();
      final master = Master.createWithSampleData();
      for (var track in master.eventTracks) {
        if (track.events.isNotEmpty) {
          expect(find.text(track.events[0].name), findsOneWidget);
          if (track.events.length > 1) {
            expect(find.text(track.events[1].name), findsOneWidget);
          }
          if (track.events.length > 2) {
            expect(find.text(track.events[2].name), findsNothing);
          }
        }
      }
    });

    testWidgets(
        'Debe expandir y contraer eventos al hacer clic en el botón mostrar más/menos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventosPage());
      await tester.pumpAndSettle();
      final master = Master.createWithSampleData();
      final trackWithManyEvents = master.eventTracks.firstWhere(
          (track) => track.events.length > 2,
          orElse: () => master.eventTracks.first);

      if (trackWithManyEvents.events.length <= 2) return;

      expect(find.text(trackWithManyEvents.events[2].name), findsNothing);
      final mostrarMasTextFinder =
          find.text("Mostrar más (${trackWithManyEvents.events.length - 2})");
      expect(mostrarMasTextFinder, findsWidgets);
      await tester.tap(mostrarMasTextFinder.first);
      await tester.pumpAndSettle();
      expect(find.text(trackWithManyEvents.events[2].name), findsOneWidget);
      expect(find.text("Mostrar menos"), findsWidgets);
      await tester.tap(find.text("Mostrar menos").first);
      await tester.pumpAndSettle();
      expect(find.text(trackWithManyEvents.events[2].name), findsNothing);
    });

    testWidgets('Debe mostrar botones de suscripción con estados correctos',
        (WidgetTester tester) async {
      final master = Master.createWithSampleData();
      final testEvent = master.eventTracks.first.events.first;
      mockUser.myEvents.add(testEvent);
      await tester.pumpWidget(createEventosPage());
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ElevatedButton, 'Suscrito'), findsWidgets);
      expect(find.widgetWithText(ElevatedButton, 'Suscribirse'), findsWidgets);
    });

    testWidgets('Debe intentar navegar al hacer tap en un evento',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventosPage());
      await tester
          .pump(); // Usa pump en lugar de pumpAndSettle para evitar renderizado completo

      // Obtener un evento de ejemplo

      // Buscar el widget tappable (InkWell) sin depender demasiado del texto
      final eventCardFinder = find.byType(InkWell).first;

      // Verificar que el widget tappable existe
      expect(eventCardFinder, findsOneWidget);

      // Simular el tap en el evento
      await tester.tap(eventCardFinder);
      await tester.pump();
    });
  });
}
