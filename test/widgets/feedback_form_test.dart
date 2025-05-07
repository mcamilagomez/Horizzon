import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';
// Ajusta la ruta según donde tengas tu FeedbackForm
import 'package:horizzon/ui/widgets/event_details/feedback_form.dart';

// Simple implementación de MasterRepository para testing
class TestMasterRepository implements MasterRepository {
  // Implementa aquí todos los métodos que necesites
  // Por ejemplo:
  @override
  Future<void> addFeedback({required int eventId, required FeedbackbyUser feedback}) async {
    // No hace nada, solo una implementación de prueba
    return;
  }

  // Añade el resto de métodos que necesites según tu interfaz
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late TestMasterRepository masterRepo;
  late Event mockEvent;
  late User mockUser;
  
  setUp(() {
    masterRepo = TestMasterRepository();
    
    // Evento de prueba
    mockEvent = Event(
      id: 1,
      eventTrackId: 1, 
      name: 'Evento de prueba',
      description: 'Descripción corta',
      longDescription: 'Descripción larga',
      eventTrackName: 'Tecnología',
      location: 'Auditorio Principal',
      initialDate: DateTime(2023, 10, 15, 9, 30),
      finalDate: DateTime(2023, 10, 15, 11, 45),
      capacity: 100,
      availableSeats: 50,
      speakers: ['Expositor 1'],
      feedbacks: [],
      coverImageUrl: 'https://example.com/cover.jpg',
      cardImageUrl: 'https://example.com/card.jpg',
    );
    
    // Ajusta según la estructura real de User
    mockUser = User(
      hash: '12345',
      myEvents: [], // Añadido basado en el error
      // Añade cualquier otro parámetro requerido
    );
  });

  testWidgets('Renderiza correctamente el formulario de feedback', 
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FeedbackForm(
            event: mockEvent,
            user: mockUser,
            color: Colors.blue,
            masterRepo: masterRepo,
          ),
        ),
      ));
      
      // Verificamos elementos básicos del UI
      expect(find.text('Reseñas'), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Enviar Review'), findsOneWidget);
    }
  );
  
  testWidgets('Permite seleccionar estrellas', 
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FeedbackForm(
            event: mockEvent,
            user: mockUser,
            color: Colors.blue,
            masterRepo: masterRepo,
          ),
        ),
      ));
      
      // Inicialmente todas las estrellas están vacías
      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
      expect(find.byIcon(Icons.star), findsNothing);
      
      // Seleccionamos 3 estrellas
      await tester.tap(find.byIcon(Icons.star_border).at(2));
      await tester.pump();
      
      // Ahora deberíamos tener 3 estrellas llenas y 2 vacías
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
    }
  );
  
  testWidgets('Muestra error si no se seleccionan estrellas', 
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FeedbackForm(
            event: mockEvent,
            user: mockUser,
            color: Colors.blue,
            masterRepo: masterRepo,
          ),
        ),
      ));
      
      // Intentamos enviar sin seleccionar estrellas
      await tester.tap(find.text('Enviar Review'));
      await tester.pumpAndSettle();
      
      // Verificamos que aparezca el SnackBar con el mensaje de error
      expect(find.text('Por favor selecciona un rating de estrellas'), findsOneWidget);
    }
  );
}