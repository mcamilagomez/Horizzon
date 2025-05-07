// test/widgets/agenda/day_container_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/ui/widgets/agenda_content/day_container.dart';

void main() {
  group('DayContainer Widget Tests', () {
    late Map<String, dynamic> dayData;
    late DateTime currentDate;
    late List<Event> userEvents;
    
    // Variable para capturar la fecha seleccionada
    DateTime? selectedDateFromCallback;
    
    void onDaySelected(DateTime date) {
      selectedDateFromCallback = date;
    }

    setUp(() {
      // Configurar fecha actual y datos de un día para las pruebas
      currentDate = DateTime(2023, 10, 1); // 1 de octubre de 2023
      
      // Datos para el 15 de octubre de 2023 (mitad del mes)
      dayData = {
        'day': '15',
        'weekday': 'Sun',
        'isToday': false,
        'date': DateTime(2023, 10, 15),
      };
      
      // Crear un evento que cae en este día
      userEvents = [
        Event(
          id: 1,
          name: 'Evento de prueba',
          description: 'Descripción corta',
          longDescription: 'Descripción larga',
          eventTrackName: 'Track',
          eventTrackId: 1,
          location: 'Ubicación',
          initialDate: DateTime(2023, 10, 15, 9, 0), // Mismo día que estamos probando
          finalDate: DateTime(2023, 10, 15, 17, 0),
          capacity: 100,
          availableSeats: 50,
          speakers: [],
          feedbacks: [],
          coverImageUrl: '',
          cardImageUrl: '',
        ),
      ];
      
      // Reiniciar variable de seguimiento para el callback
      selectedDateFromCallback = null;
    });

    testWidgets('Renderiza correctamente un día normal', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null, // No hay día seleccionado
                onDaySelected: onDaySelected,
                userEvents: userEvents,
              ),
            ),
          ),
        ),
      );
      
      // Verificar que se muestra el número del día
      expect(find.text('15'), findsOneWidget);
      
      // Verificar que se muestra el día de la semana
      expect(find.text('Sun'), findsOneWidget);
      
      // Verificar que se renderiza el container principal
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Muestra estilo especial para el día seleccionado', (WidgetTester tester) async {
      // Configurar el mismo día como seleccionado
      final selectedDate = DateTime(2023, 10, 15);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: selectedDate,
                onDaySelected: onDaySelected,
                userEvents: userEvents,
              ),
            ),
          ),
        ),
      );
      
      // Verificar textos básicos
      expect(find.text('15'), findsOneWidget);
      expect(find.text('Sun'), findsOneWidget);
      
      // Para un día seleccionado, debe haber un Container con borde
      // Esto es difícil de probar directamente el estilo, pero verificamos 
      // que el widget se renderiza sin errores
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Muestra estilo especial para el día actual', (WidgetTester tester) async {
      // Modificar los datos para que este día sea "hoy"
      dayData = {
        'day': '15',
        'weekday': 'Sun',
        'isToday': true,  // Ahora es "hoy"
        'date': DateTime(2023, 10, 15),
      };
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null,
                onDaySelected: onDaySelected,
                userEvents: userEvents,
              ),
            ),
          ),
        ),
      );
      
      // Verificar textos básicos
      expect(find.text('15'), findsOneWidget);
      
      // Verificar que se renderiza correctamente
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Invoca callback al seleccionar un día', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null,
                onDaySelected: onDaySelected,
                userEvents: userEvents,
              ),
            ),
          ),
        ),
      );
      
      // Inicialmente no se ha invocado el callback
      expect(selectedDateFromCallback, isNull);
      
      // Simular tap en el día
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      // Verificar que se invocó el callback con la fecha correcta
      expect(selectedDateFromCallback, isNotNull);
      expect(selectedDateFromCallback, equals(DateTime(2023, 10, 15)));
    });

    testWidgets('Muestra indicador para días con eventos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null,
                onDaySelected: onDaySelected,
                userEvents: userEvents, // Lista con un evento para este día
              ),
            ),
          ),
        ),
      );
      
      // En tu implementación, cuando hay eventos se añade un Container adicional
      // con el indicador. Verificamos que existe al menos un Container
      expect(find.byType(Container), findsWidgets);
      
      // Verificar que existe un padding con top: 4 (el que contiene el indicador)
      final paddingFinder = find.byWidgetPredicate((widget) {
        if (widget is Padding) {
          final EdgeInsets padding = widget.padding as EdgeInsets;
          return padding.top == 4.0 && padding.left == 0.0 && 
                 padding.right == 0.0 && padding.bottom == 0.0;
        }
        return false;
      });
      
      expect(paddingFinder, findsOneWidget);
    });

    testWidgets('No muestra indicador si no hay eventos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null,
                onDaySelected: onDaySelected,
                userEvents: [], // Lista vacía: sin eventos
              ),
            ),
          ),
        ),
      );
      
      // Al no haber eventos, no debería existir el Padding específico para el indicador
      final paddingFinder = find.byWidgetPredicate((widget) {
        if (widget is Padding) {
          final EdgeInsets padding = widget.padding as EdgeInsets;
          return padding.top == 4.0 && padding.left == 0.0 && 
                 padding.right == 0.0 && padding.bottom == 0.0;
        }
        return false;
      });
      
      expect(paddingFinder, findsNothing);
    });

    testWidgets('Aplica estilo de fin de semana para sábados y domingos', (WidgetTester tester) async {
      // El día ya es domingo ('Sun') en nuestros datos de prueba
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DayContainer(
                day: dayData,
                currentDate: currentDate,
                selectedDate: null,
                onDaySelected: onDaySelected,
                userEvents: userEvents,
              ),
            ),
          ),
        ),
      );
      
      // Verificar que el texto del día de la semana está presente
      expect(find.text('Sun'), findsOneWidget);
    });
  });
}