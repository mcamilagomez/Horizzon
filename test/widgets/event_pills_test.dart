import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:horizzon/ui/widgets/event_pill.dart';
import 'package:horizzon/ui/widgets/event_pills_list.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // Configuración inicial
  final User mockUser = User(
    hash: 'user123',
    myEvents: [],
  );

  // Función para crear eventos mock sin dependencias de assets
  Event createMockEvent({required int id, required String name}) {
    return Event(
      id: id,
      name: name,
      description: 'Description $id',
      longDescription: '',
      speakers: [],
      feedbacks: [],
      initialDate: DateTime.now(),
      finalDate: DateTime.now().add(const Duration(hours: 1)),
      location: '',
      capacity: 0,
      availableSeats: 0,
      coverImageUrl: '', // Vacío para evitar carga de assets
      cardImageUrl: '', // Vacío para evitar carga de assets
      eventTrackName: '',
    );
  }

  group('EventPillsList Widget Tests', () {
    testWidgets('should render empty state when no events', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventPillsList(
              events: [],
              colorPrincipal: Colors.blue,
              user: mockUser,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('No tienes recordatorios aún'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(EventPill), findsNothing);
    });

    testWidgets('should render list of EventPills when events are provided', (WidgetTester tester) async {
      // Arrange
      final events = [
        createMockEvent(id: 1, name: 'Event 1'),
        createMockEvent(id: 2, name: 'Event 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventPillsList(
              events: events,
              colorPrincipal: Colors.red,
              user: mockUser,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(EventPillsList), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(EventPill), findsNWidgets(events.length));
    });

    testWidgets('should have correct padding and dimensions', (WidgetTester tester) async {
      // Arrange
      final events = [createMockEvent(id: 1, name: 'Event 1')];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventPillsList(
              events: events,
              colorPrincipal: Colors.green,
              user: mockUser,
            ),
          ),
        ),
      );

      // Act
      final listView = tester.widget<ListView>(find.byType(ListView));
      final container = tester.widget<SizedBox>(find.byType(SizedBox).first);

      // Assert
      expect(listView.padding, const EdgeInsets.symmetric(horizontal: 16));
      expect(container.height, 150);
    });
  });
}