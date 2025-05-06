import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/reminders/event_pill.dart';
import 'package:horizzon/ui/widgets/reminders/event_pills_list.dart';

// Mocks
class MockEvent extends Mock implements Event {}

class MockUser extends Mock implements User {}

void main() {
  late List<Event> events;
  late User user;
  const Color testColor = Colors.blue;
  const Color colorPrincipal = Colors.blue;

  // Crea eventos reales (sin usar Mock) para pruebas visuales
  Event createRealEvent({required int id, required String name}) {
    return Event(
      id: id,
      name: name,
      eventTrackId: 1,
      description: 'Description $id',
      longDescription: 'Long description $id',
      speakers: ['Speaker $id'],
      feedbacks: [],
      initialDate: DateTime.now(),
      finalDate: DateTime.now().add(const Duration(hours: 1)),
      location: 'Location $id',
      capacity: 100,
      availableSeats: 50,
      coverImageUrl: '',
      cardImageUrl: '',
      eventTrackName: 'Track $id',
    );
  }

  Widget createTestWidget({
    required List<Event> events,
    Color colorPrincipal = testColor,
    required User user,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: EventPillsList(
          events: events,
          colorPrincipal: colorPrincipal,
          user: user,
        ),
      ),
    );
  }

  setUp(() {
    events = List.generate(
        3, (index) => createRealEvent(id: index, name: 'Event $index'));
    user = User(hash: 'user123', myEvents: []);
  });

  group('EventPillsList Widget Tests', () {
    testWidgets('debe mostrar mensaje cuando no hay eventos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(events: [], user: user));

      expect(find.text('No tienes recordatorios aún'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(EventPill), findsNothing);

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 50);
    });

    testWidgets('mensaje de texto tiene color gris cuando no hay eventos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(events: [], user: user));

      final textWidget =
          tester.widget<Text>(find.text('No tienes recordatorios aún'));
      expect(textWidget.style?.color, Colors.grey);
    });
    testWidgets('Debe mostrar mensaje cuando la lista de eventos está vacía',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventPillsList(
              events: [],
              colorPrincipal: colorPrincipal,
              user: user,
            ),
          ),
        ),
      );

      // Verifica el mensaje
      expect(find.text('No tienes recordatorios aún'), findsOneWidget);
      final textWidget =
          tester.widget<Text>(find.text('No tienes recordatorios aún'));
      expect(textWidget.style?.color, Colors.grey);

      // Verifica la altura del contenedor
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 50);
      expect(find.byType(ListView), findsNothing);
    });
  });
}
