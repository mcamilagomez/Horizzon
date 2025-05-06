import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/controllers/bottom_nav_controller.dart';

void main() {
  setUp(() {
    //  registramos el ThemeController para nuestro test 
    Get.put(ThemeController());
    Get.put(BottomNavController());
  });
  
  tearDown(() {
    Get.reset();  // Limpiamos después de cada test
  });
  
  test('ThemeController initialization test', () {
    // Verificamos que podemos obtener el ThemeController
    final themeController = Get.find<ThemeController>();
    expect(themeController, isNotNull);
    
    themeController.color.value = Colors.red;
    expect(themeController.color.value, Colors.red);
  });
  
  test('BottomNavController initialization test', () {
    // Verificamos que podemos obtener el BottomNavController
    final bottomNavController = Get.find<BottomNavController>();
    expect(bottomNavController, isNotNull);
  });
  
  testWidgets('Simple widget test', (WidgetTester tester) async {
    // Un test de widget muy simple que usa GetX
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Center(
            child: Obx(() => Text(
              'Color: ${Get.find<ThemeController>().color.value}',
              style: TextStyle(color: Get.find<ThemeController>().color.value),
            )),
          ),
        ),
      ),
    );
    
    // Cambiamos el color
    final themeController = Get.find<ThemeController>();
    themeController.color.value = Colors.blue;
    await tester.pump();
    
    // Verificamos que el widget tiene el texto esperado
    expect(find.textContaining('Color:'), findsOneWidget);
  });
}