// test/widgets/agenda/day_calendar_strip_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/ui/widgets/agenda_content/day_calendar_strip.dart';
import 'package:horizzon/ui/widgets/agenda_content/day_container.dart';
import 'package:mockito/mockito.dart';

// Mock para capturar la fecha seleccionada
class MockDateCallback extends Mock {
  void call(DateTime date);
}

void main() {
  group('DayCalendarStrip Widget Tests', () {
    late ScrollController scrollController;
    late List<Map<String, dynamic>> daysInMonth;
    late List<Event> userEvents;
    
    // Mock para evento de callback
    void mockOnDaySelected(DateTime date) {
      // Simplemente registrar la llamada, no necesitamos mockito aquí
    }

    setUp(() {
      scrollController = ScrollController();

      // Crear datos de prueba para los días del mes
      final today = DateTime.now();
      daysInMonth = List.generate(31, (index) {
        final day = index + 1;
        final date = DateTime(today.year, today.month, day);
        return {
          'day': day.toString(),
          'weekday': _getWeekdayShort(date.weekday),
          'isToday': day == today.day,
          'date': date,
        };
      });

      // Lista de eventos para probar
      userEvents = [
        Event(
          id: 1,
          name: 'Evento de prueba',
          description: 'Descripción corta',
          longDescription: 'Descripción larga',
          eventTrackName: 'Track',
          eventTrackId: 1,
          location: 'Ubicación',
          initialDate: DateTime(today.year, today.month, 15),
          finalDate: DateTime(today.year, today.month, 15),
          capacity: 100,
          availableSeats: 50,
          speakers: [],
          feedbacks: [],
          coverImageUrl: '',
          cardImageUrl: '',
        ),
      ];
    });

    tearDown(() {
      scrollController.dispose();
    });

    testWidgets('Renderiza los componentes principales correctamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DayCalendarStrip(
              daysInMonth: daysInMonth,
              currentDate: DateTime.now(),
              selectedDate: null,
              scrollController: scrollController,
              onDaySelected: mockOnDaySelected,
              userEvents: userEvents,
            ),
          ),
        ),
      );

      // Verificar que existe el widget principal
      expect(find.byType(DayCalendarStrip), findsOneWidget);
      
      // Verificar elementos clave de navegación
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      
      // Verificar que existe un ListView
      expect(find.byType(ListView), findsOneWidget);
      
      // Verificar que existen contenedores de días
      expect(find.byType(DayContainer), findsWidgets);
    });

    testWidgets('Los botones de navegación activan el desplazamiento', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DayCalendarStrip(
              daysInMonth: daysInMonth,
              currentDate: DateTime.now(),
              selectedDate: null,
              scrollController: scrollController,
              onDaySelected: mockOnDaySelected,
              userEvents: userEvents,
            ),
          ),
        ),
      );

      // Verificar posición inicial
      expect(scrollController.offset, 0.0);
      
      // Hacer tap en el botón de navegación derecho
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle(); // Esperar a que se complete la animación
      
      // La posición debe haber cambiado (aumentado)
      expect(scrollController.offset, greaterThan(0.0));
    });

    testWidgets('Muestra correctamente los contenedores para días reducidos', (WidgetTester tester) async {
      // Usar solo los primeros 3 días para simplificar
      final smallDaysList = daysInMonth.sublist(0, 3);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DayCalendarStrip(
              daysInMonth: smallDaysList,
              currentDate: DateTime.now(),
              selectedDate: null,
              scrollController: scrollController,
              onDaySelected: mockOnDaySelected,
              userEvents: userEvents,
            ),
          ),
        ),
      );

      // Debe haber al menos algunos DayContainer
      expect(find.byType(DayContainer), findsWidgets);
      
      // El número puede variar según el dispositivo virtual, así que no verificamos la cantidad exacta
    });
  });
}

// Función auxiliar para obtener la abreviatura del día de la semana
String _getWeekdayShort(int weekday) {
  const weekdays = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return weekdays[weekday];
}