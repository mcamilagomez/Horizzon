import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/event_pill.dart'; // Ajusta la ruta según tu estructura

void main() {
  late User mockUser;
  late Event mockEvent;
  const Color testColor = Colors.blue;

  setUp(() {
    mockUser = User(hash: 'test123', myEvents: []);
    mockEvent = Event(
      id: 1,
      name: 'Test Event',
      description: 'This is a test event',
      initialDate: DateTime.now().add(const Duration(days: 1)),
      finalDate: DateTime.now().add(const Duration(days: 2)),
      cardImageUrl: 'assets/test_image.jpg',
      longDescription: 'Long description',
      speakers: ['Speaker 1'],
      feedbacks: [],
      location: 'Test Location',
      capacity: 100,
      availableSeats: 50,
      coverImageUrl: 'assets/cover_image.jpg',
      eventTrackName: 'Test Track',
    );
  });

  Widget createEventPill() {
    return MaterialApp(
      home: Scaffold(
        body: EventPill(
          event: mockEvent,
          colorPrincipal: testColor,
          user: mockUser,
        ),
      ),
    );
  }

  group('EventPill Widget Tests', () {
    testWidgets('Debe mostrar el nombre del evento', (WidgetTester tester) async {
      await tester.pumpWidget(createEventPill());
      await tester.pump();

      expect(find.text('Test Event'), findsOneWidget);
    });

    testWidgets('Debe mostrar el estado del evento', (WidgetTester tester) async {
      await tester.pumpWidget(createEventPill());
      await tester.pump();

      expect(find.text('Próximo'), findsOneWidget); // Asume "Próximo" para evento futuro
    });

    testWidgets('Debe permitir tap en el GestureDetector sin crash', (WidgetTester tester) async {
      await tester.pumpWidget(createEventPill());
      await tester.pump();

      expect(find.byType(GestureDetector), findsOneWidget);
      await tester.tap(find.byType(GestureDetector));
      await tester.pump(); // Solo verificamos que no falle al hacer tap
    });

    testWidgets('Debe renderizar con un contenedor básico', (WidgetTester tester) async {
      await tester.pumpWidget(createEventPill());
      await tester.pump();

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });
}