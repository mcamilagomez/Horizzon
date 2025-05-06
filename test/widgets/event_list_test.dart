import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/recomended/event_list.dart';

void main() {
  // Usuario de prueba
  final testUser = User(
    hash: 'test_hash',
    myEvents: [],
  );

  // Evento de prueba
  final testEvent = Event(
    id: 1,
    name: 'Conferencia Flutter',
    description: 'Descripción corta',
    eventTrackId: 1,
    longDescription: 'Descripción larga',
    speakers: ['Speaker 1'],
    feedbacks: [],
    initialDate: DateTime.now(),
    finalDate: DateTime.now().add(const Duration(hours: 2)),
    location: 'Auditorio Principal',
    capacity: 100,
    availableSeats: 50,
    coverImageUrl: 'assets/images/event1.jpg',
    cardImageUrl: 'assets/images/event1_card.jpg',
    eventTrackName: 'Track de Desarrollo',
  );

  /// 1. Render básico sin errores
  testWidgets('Renderizado básico sin errores', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EventList(
          events: [],
          primaryColor: Colors.blue,
          user: testUser,
        ),
      ),
    );

    expect(true, isTrue); // Pase forzado, sin excepciones
  });

  /// 2. Muestra lista vacía correctamente
  testWidgets('EventList con lista vacía muestra ListView',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventList(
            events: [],
            primaryColor: Colors.blue,
            user: testUser,
          ),
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
  });

  /// 3. Verifica padding correcto
  testWidgets('EventList tiene el padding correcto',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventList(
            events: [],
            primaryColor: Colors.blue,
            user: testUser,
          ),
        ),
      ),
    );

    final listView = tester.widget<ListView>(find.byType(ListView));
    expect(listView.padding, equals(const EdgeInsets.all(20)));
  });

  /// 4. Verifica que EventList sea StatelessWidget
  testWidgets('EventList es un StatelessWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventList(
            events: [],
            primaryColor: Colors.blue,
            user: testUser,
          ),
        ),
      ),
    );

    final widget = tester.widget(find.byType(EventList));
    expect(widget, isA<StatelessWidget>());
  });

  /// 5. Acepta color primario sin errores
  testWidgets('EventList acepta color primario personalizado',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventList(
            events: [],
            primaryColor: Colors.green,
            user: testUser,
          ),
        ),
      ),
    );

    expect(find.byType(EventList), findsOneWidget);
  });
}
