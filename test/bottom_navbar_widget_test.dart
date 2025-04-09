import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:horizzon/ui/widgets/bottom_nav_bar.dart'; // Ajusta la ruta según tu estructura
import 'package:horizzon/ui/controllers/bottom_nav_controller.dart'; // Ajusta la ruta según tu estructura

void main() {
  // Configuración inicial para GetX
  setUp(() {
    // Inicializa GetX antes de cada prueba
    Get.testMode = true;
    // Registra el controlador en el sistema de GetX
    if (!Get.isRegistered<BottomNavController>()) {
      Get.put(BottomNavController());
    }
  });

  tearDown(() {
    // Limpia el controlador después de cada prueba
    Get.reset();
  });

  // Método auxiliar para crear el widget bajo prueba
  Widget createBottomNavBar() {
    return const MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  group('BottomNavBar Widget Tests', () {

    testWidgets('Debe mostrar el ícono activo correcto según el índice actual', (WidgetTester tester) async {
      final controller = Get.find<BottomNavController>();

      // Establece el índice en 1 (Eventos)
      controller.currentIndex.value = 1;

      await tester.pumpWidget(createBottomNavBar());
      await tester.pump(); // Actualiza el estado de Obx

      // Verifica que el ícono activo de "event" esté presente
      expect(find.byIcon(Icons.event), findsOneWidget);
      // Verifica que los demás íconos sean los no activos
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('Debe cambiar el índice al hacer tap en un ítem', (WidgetTester tester) async {
      final controller = Get.find<BottomNavController>();

      // Índice inicial debe ser 0
      expect(controller.currentIndex.value, 0);

      await tester.pumpWidget(createBottomNavBar());
      await tester.pump();

      // Toca el segundo ítem (índice 1, Eventos)
      await tester.tap(find.byIcon(Icons.event_outlined));
      await tester.pump(); // Actualiza el estado

      // Verifica que el índice cambió a 1
      expect(controller.currentIndex.value, 1);
      expect(find.byIcon(Icons.event), findsOneWidget); // Ícono activo
    });

    testWidgets('Debe tener fondo blanco', (WidgetTester tester) async {
      await tester.pumpWidget(createBottomNavBar());
      await tester.pump();

      final bottomNavBar = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavBar.backgroundColor, Colors.white);
    });
  });
}