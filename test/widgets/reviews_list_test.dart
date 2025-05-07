import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart'; // Para FeedbackbyUser
import 'package:horizzon/ui/widgets/event_details/reviews_list.dart'; // Ajusta la ruta según tu estructura

void main() {
  group('EventReviewsList', () {
    testWidgets('Muestra mensaje cuando no hay reseñas',
        (WidgetTester tester) async {
      // Renderiza el widget con una lista vacía de feedbacks
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: EventReviewsList(
            feedbacks: [],
            color: Colors.blue,
          ),
        ),
      ));

      // Verifica que se muestre el mensaje "sin reseñas"
      expect(find.text('Aún no hay reviews para este evento'), findsOneWidget);
      
      // Verifica que no haya estrellas ni avatares
      expect(find.byIcon(Icons.star), findsNothing);
      expect(find.byIcon(Icons.star_border), findsNothing);
      expect(find.byIcon(Icons.person), findsNothing);
    });

    testWidgets('Muestra lista de reseñas correctamente',
        (WidgetTester tester) async {
      // Crea una lista de feedbacks de prueba
      final feedbacks = [
        FeedbackbyUser(
          userId: 'usuario1',
          stars: 4,
          comment: 'Excelente evento, muy recomendado.',
        ),
        FeedbackbyUser(
          userId: 'usuario_con_nombre_largo',
          stars: 3,
          comment: 'Bueno pero podría mejorar.',
        ),
        FeedbackbyUser(
          userId: 'usuario3',
          stars: 5,
          comment: '',
        ),
      ];

      // Renderiza el widget con la lista de feedbacks
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: EventReviewsList(
              feedbacks: feedbacks,
              color: Colors.blue,
            ),
          ),
        ),
      ));

      // Verifica que NO se muestre el mensaje "sin reseñas"
      expect(find.text('Aún no hay reviews para este evento'), findsNothing);
      
      // Verifica los usuarios (incluyendo el truncado)
      expect(find.text('usuario1'), findsOneWidget);
      expect(find.text('usuario_...'), findsOneWidget); // nombre truncado
      expect(find.text('usuario3'), findsOneWidget);
      
      // Verifica los comentarios
      expect(find.text('Excelente evento, muy recomendado.'), findsOneWidget);
      expect(find.text('Bueno pero podría mejorar.'), findsOneWidget);
      
      // Verifica las estrellas
      // Usuario 1: 4 estrellas llenas, 1 vacía
      // Usuario 2: 3 estrellas llenas, 2 vacías
      // Usuario 3: 5 estrellas llenas, 0 vacías
      // Total: 12 estrellas llenas, 3 vacías
      expect(find.byIcon(Icons.star), findsNWidgets(12));
      expect(find.byIcon(Icons.star_border), findsNWidgets(3));
      
      // Verifica los avatares (íconos de persona)
      expect(find.byIcon(Icons.person), findsNWidgets(3));
    });

    testWidgets('Maneja correctamente reseñas sin comentarios',
        (WidgetTester tester) async {
      // Crea un feedback sin comentario
      final feedbacks = [
        FeedbackbyUser(
          userId: 'usuario1',
          stars: 3,
          comment: '', // Comentario vacío
        ),
      ];

      // Renderiza el widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: EventReviewsList(
            feedbacks: feedbacks,
            color: Colors.red,
          ),
        ),
      ));

      // Verifica que se muestre el usuario y las estrellas
      expect(find.text('usuario1'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
      
      // Verifica que no se muestre un Text vacío para el comentario
      // (esto es más complejo de verificar directamente, pero verificamos
      // la estructura general)
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsWidgets);
      
      // El contenedor principal debe tener tres elementos:
      // 1. Row con el avatar y nombre de usuario
      // 2. Row con las estrellas
      // 3. No debería haber un tercer elemento Text
      
      // Verificamos indirectamente al contar la cantidad de Texts
      // Solo deben haber 1 Text (el nombre de usuario)
      expect(find.descendant(
        of: find.byType(Padding).first, 
        matching: find.byType(Text)
      ), findsOneWidget);
    });

    testWidgets('Aplica el color correcto a los avatares',
        (WidgetTester tester) async {
      final testColor = Colors.purple;
      final feedbacks = [
        FeedbackbyUser(
          userId: 'usuario1',
          stars: 4,
          comment: 'Comentario de prueba',
        ),
      ];

      // Renderiza el widget con el color de prueba
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: EventReviewsList(
            feedbacks: feedbacks,
            color: testColor,
          ),
        ),
      ));

      // Encuentra el CircleAvatar
      final avatarFinder = find.byType(CircleAvatar);
      expect(avatarFinder, findsOneWidget);
      
      // Verifica el color del avatar
      final avatar = tester.widget<CircleAvatar>(avatarFinder);
      expect(avatar.backgroundColor, equals(testColor.withOpacity(0.2)));
      
      // Verifica el color del icono dentro del avatar
      final iconFinder = find.descendant(
        of: avatarFinder,
        matching: find.byIcon(Icons.person),
      );
      expect(iconFinder, findsOneWidget);
      
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, equals(testColor));
    });
  });
}