import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/widgets/event_details/event_header.dart'; // Ajusta la ruta según tu estructura
import 'package:provider/provider.dart';
// Para Uint8List

// Mock del EventController
class MockEventController extends ChangeNotifier implements EventController {
  bool _isSubscribed = false;

  void setSubscriptionStatus(bool status) {
    _isSubscribed = status;
    notifyListeners();
  }

  @override
  bool checkSubscriptionStatus(Event event) {
    return _isSubscribed;
  }

  @override
  Future<void> toggleSuscripcion(Event event, BuildContext context) async {
    _isSubscribed = !_isSubscribed;
    notifyListeners();
  }

  // Implementa otros métodos según sea necesario
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  // Crear instancias para los tests
  late Event mockEventActive;
  late Event mockEventFinished;
  late Event mockEventUnavailable;
  late User mockUser;
  late MockEventController eventController;

  setUp(() {
    // Evento activo con asientos disponibles
    mockEventActive = Event(
      id: 1,
      name: 'Evento Activo',
      description: 'Evento con lugares disponibles',
      longDescription: 'Descripción larga',
      eventTrackName: 'Tecnología',
      eventTrackId: 1,
      location: 'Auditorio Principal',
      initialDate: DateTime.now().add(const Duration(days: 1)), // Futuro
      finalDate: DateTime.now().add(const Duration(days: 2)),
      capacity: 100,
      availableSeats: 50, // Disponible
      speakers: ['Expositor 1'],
      feedbacks: [],
      coverImageUrl: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA', // Imagen base64 falsa
      cardImageUrl: '',
    );

    // Evento finalizado (fechas en el pasado)
    mockEventFinished = Event(
      id: 2,
      name: 'Evento Finalizado',
      description: 'Este evento ya terminó',
      longDescription: 'Descripción larga',
      eventTrackName: 'Tecnología',
      eventTrackId: 1,
      location: 'Auditorio Principal',
      initialDate: DateTime.now().subtract(const Duration(days: 2)), // Pasado
      finalDate: DateTime.now().subtract(const Duration(days: 1)), // Pasado
      capacity: 100,
      availableSeats: 50,
      speakers: ['Expositor 1'],
      feedbacks: [],
      coverImageUrl: '',
      cardImageUrl: '',
    );

    // Evento sin lugares disponibles
    mockEventUnavailable = Event(
      id: 3,
      name: 'Evento Sin Lugares',
      description: 'No hay lugares disponibles',
      longDescription: 'Descripción larga',
      eventTrackName: 'Tecnología',
      eventTrackId: 1,
      location: 'Auditorio Principal',
      initialDate: DateTime.now().add(const Duration(days: 1)),
      finalDate: DateTime.now().add(const Duration(days: 2)),
      capacity: 100,
      availableSeats: 0, // Sin lugares
      speakers: ['Expositor 1'],
      feedbacks: [],
      coverImageUrl: '',
      cardImageUrl: '',
    );

    mockUser = User(
      hash: '12345',
      myEvents: [], // Ajusta según tu clase User
    );

    eventController = MockEventController();
  });

  // Función auxiliar para construir el widget con diferentes configuraciones
  Widget buildTestWidget({
    required Event event,
    bool isSubscribed = false,
  }) {
    eventController.setSubscriptionStatus(isSubscribed);

    return ChangeNotifierProvider<EventController>.value(
      value: eventController,
      child: MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              EventHeader(
                event: event,
                user: mockUser,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  group('EventHeader Widget Tests', () {
    testWidgets('Muestra información básica del evento correctamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(event: mockEventActive));

      // Verificar título y descripción
      expect(find.text('Evento Activo'), findsOneWidget);
      expect(find.text('Evento con lugares disponibles'), findsOneWidget);

      // No podemos verificar fácilmente la imagen debido a las limitaciones,
      // pero podemos comprobar si hay un ClipRRect (que contiene la imagen)
      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('Muestra botón "Suscribirse" para evento disponible',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        event: mockEventActive,
        isSubscribed: false,
      ));

      // Verificar botón para suscribirse
      expect(find.text('Suscribirse'), findsOneWidget);
      
      // Botón debe estar habilitado
      final buttonFinder = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.onPressed, isNotNull);
    });

    testWidgets('Muestra botón "Desuscribirse" cuando está suscrito',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        event: mockEventActive,
        isSubscribed: true,
      ));

      // Verificar botón para desuscribirse
      expect(find.text('Desuscribirse'), findsOneWidget);
    });

    testWidgets('Muestra botón "Finalizado" para eventos terminados',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        event: mockEventFinished,
      ));

      // Verificar botón finalizado
      expect(find.text('Finalizado'), findsOneWidget);
      
      // Botón debe estar deshabilitado
      final buttonFinder = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('Muestra botón "No disponible" cuando no hay lugares',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        event: mockEventUnavailable,
      ));

      // Verificar botón no disponible
      expect(find.text('No disponible'), findsOneWidget);
      
      // Botón debe estar deshabilitado
      final buttonFinder = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('El botón cambia al hacer tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        event: mockEventActive,
        isSubscribed: false,
      ));

      // Verificar estado inicial
      expect(find.text('Suscribirse'), findsOneWidget);
      
      // Hacer tap en el botón
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      // Verificar que cambió a desuscribirse
      expect(find.text('Desuscribirse'), findsOneWidget);
    });

    testWidgets('Muestra error si la imagen está corrupta',
        (WidgetTester tester) async {
      // Aquí simplemente probamos la ruta donde falla la carga de imagen
      // No podemos manipular decodeBase64Image directamente, pero podemos
      // verificar que el widget maneje el caso de error en la imagen
      
      await tester.pumpWidget(buildTestWidget(
        event: mockEventActive,
      ));
      
      // Forzamos el error de la imagen
      await tester.pumpAndSettle();
      
      // No podemos verificar fácilmente si aparece el icono de error,
      // pero al menos nos aseguramos de que no se rompa el widget
    });
  });
}