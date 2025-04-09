import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/event_list.dart'; // Ajusta la ruta según tu estructura
import 'package:horizzon/ui/widgets/event_card.dart'; // Ajusta la ruta según tu estructura

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
        cardImageUrl: 'assets/test_image.jpg',
        longDescription: 'Long description 1',
        speakers: ['Speaker 1'],
        feedbacks: [],
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
        cardImageUrl: 'assets/test_image.jpg',
        longDescription: 'Long description 2',
        speakers: ['Speaker 2'],
        feedbacks: [],
        location: 'Location 2',
        capacity: 200,
        availableSeats: 150,
        coverImageUrl: 'assets/cover_image.jpg',
        eventTrackName: 'Track 2',
      ),
    ];
  });

  Widget createEventList({
    List<Event> events = const [],
    Color primaryColor = testColor,
    User? user,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: EventList(
          events: events,
          primaryColor: primaryColor,
          user: user ?? mockUser,
        ),
      ),
    );
  }

  group('EventList Widget Tests', () {
    testWidgets('Debe mostrar una lista vacía cuando no hay eventos', (WidgetTester tester) async {
      await tester.pumpWidget(createEventList(events: []));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(EventCard), findsNothing);

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.padding, const EdgeInsets.all(20));
    });


  });
}