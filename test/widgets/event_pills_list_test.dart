import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/reminders/event_pill.dart';
import 'package:horizzon/ui/widgets/reminders/event_pills_list.dart'; // Asegúrate de que esta importación sea correcta

void main() {
  // Datos de prueba
  final testUser = User(
    hash: 'user123',
    myEvents: [],
  );

  final testEvent = Event(
    id: 1,
    name: 'Test Event',
    eventTrackId: 1,
    description: 'Short description',
    longDescription: 'Long description of the event',
    speakers: ['Speaker 1', 'Speaker 2'],
    feedbacks: [
      FeedbackbyUser(
        userId: 'user123',
        stars: 5,
        comment: 'Great event!',
      ),
    ],
    initialDate: DateTime(2025, 5, 10),
    finalDate: DateTime(2025, 5, 11),
    location: 'Test Location',
    capacity: 100,
    availableSeats: 50,
    coverImageUrl: 'https://example.com/cover.jpg',
    cardImageUrl: 'https://example.com/card.jpg',
    eventTrackName: 'Tech Track',
  );

  final testColor = Colors.blue;

  group('EventPillsList Widget Tests', () {
    testWidgets('Muestra EventPill cuando hay eventos',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventPillsList(
              events: [],
              colorPrincipal: testColor,
              user: testUser,
            ),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('No tienes recordatorios aún'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(EventPill), findsNothing);
    });
  });
}
