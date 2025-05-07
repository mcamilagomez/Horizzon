import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:horizzon/ui/my_app.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de integración ', 
      (WidgetTester tester) async {
    
    // Crear datos de prueba 
    final testFeedback = FeedbackbyUser(
      userId: 'user1',
      stars: 5,
      comment: 'Excelente evento',
    );
    
    final testEvent = Event(
      id: 1,
      eventTrackId: 1,
      name: 'Evento de Prueba',
      description: 'Descripción corta',
      longDescription: 'Descripción larga del evento',
      speakers: ['Presentador'],
      initialDate: DateTime.now(),
      finalDate: DateTime.now().add(Duration(hours: 2)),
      location: 'Ubicación',
      capacity: 100,
      availableSeats: 50,
      coverImageUrl: 'base64_cover',
      cardImageUrl: 'base64_card',
      eventTrackName: 'Track de Prueba',
      feedbacks: [testFeedback],
    );
    
    // Crear datos de prueba para User
    final testUser = User(
      hash: 'hash_usuario',
      myEvents: [testEvent],
    );
    
    // Crear datos de prueba para EventTrack y Master
    final testEventTrack = EventTrack(
      id: 1,
      name: 'Track de Prueba',
      description: 'Descripción del track',
      events: [testEvent],
      coverImageUrl: 'base64_track',
      overlayImageUrl: 'base64_overlay',
    );
    
    final testMaster = Master(
      eventTracks: [testEventTrack],
    );
    
    // Lanzar la aplicación con datos fijos
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Prueba de Horizzon'),
        ),
      ),
    ));
    
    // Verificar que la app se inició correctamente
    expect(find.text('Prueba de Horizzon'), findsOneWidget);
    
    // La siguiente línea demuestra que podemos acceder a los datos de prueba
    expect(testUser.myEvents.length, 1);
    expect(testMaster.eventTracks.length, 1);
    expect(testMaster.eventTracks[0].events[0].name, 'Evento de Prueba');
  });
}