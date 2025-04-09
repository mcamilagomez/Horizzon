import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/event_pills_list.dart';

void main() {
  late User mockUser;
  late List<Event> mockEvents;
  const Color testColor = Colors.blue;

  setUp(() {
    mockUser = User(hash: 'test123', myEvents: []);
    mockEvents = [
      Event(
        id: 1,
        name: 'Event 1',
        description: 'Description 1',
        initialDate: DateTime.now().add(const Duration(days: 1)),
        finalDate: DateTime.now().add(const Duration(days: 2)),
        cardImageUrl: '',
        longDescription: 'Long description 1',
        speakers: ['Speaker 1'],
        feedbacks: [], // Ahora es List<String>
        location: 'Location 1',
        capacity: 100,
        availableSeats: 50,
        coverImageUrl: 'assets/cover_image.jpg',
        eventTrackName: 'Track 1',
      ),
      Event(
        id: 2,
        name: 'Event 2',
        description: 'Description 2',
        initialDate: DateTime.now().add(const Duration(days: 3)),
        finalDate: DateTime.now().add(const Duration(days: 4)),
        cardImageUrl: '',
        longDescription: 'Long description 2',
        speakers: ['Speaker 2'],
        feedbacks: [], // Ahora es List<String>
        location: 'Location 2',
        capacity: 200,
        availableSeats: 150,
        coverImageUrl: 'assets/cover_image.jpg',
        eventTrackName: 'Track 2',
      ),
    ];
  });

  Widget createEventPillsList({
    List<Event> events = const [],
    Color colorPrincipal = testColor,
    User? user,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: EventPillsList(
          events: events,
          colorPrincipal: colorPrincipal,
          user: user ?? mockUser,
        ),
      ),
    );
  }

  group('EventPillsList Widget Tests', () {
    testWidgets('Debe mostrar mensaje cuando la lista de eventos está vacía',
        (WidgetTester tester) async {
      await tester.pumpWidget(createEventPillsList(events: []));
      await tester.pump();

      expect(find.text('No tienes recordatorios aún'), findsOneWidget);
      final textWidget =
          tester.widget<Text>(find.text('No tienes recordatorios aún'));
      expect(textWidget.style?.color, Colors.grey);

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 50);
      expect(find.byType(ListView), findsNothing);
    });
  });
}
