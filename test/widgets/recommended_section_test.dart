import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/widgets/home_content/recommended_section.dart';
import 'package:horizzon/ui/widgets/recomended/event_list.dart';

// Clase personalizada para traducciones
class TestTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {'home.recommended': 'Recommended'},
      };
}

// Mock  para ThemeController
class MockThemeController extends GetxController implements ThemeController {
  @override
  RxBool isDark = false.obs;

  @override
  Rx<Color> color = Colors.blue.obs;

  @override
  void setColor(Color newColor) {
    color.value = newColor;
  }

  @override
  void toggleTheme() {
    isDark.value = !isDark.value;
  }

  @override
  ThemeData get darkTheme => ThemeData.dark();

  @override
  ThemeData get lightTheme => ThemeData.light();
}

void main() {
  setUp(() {
    // Inicializar GetX con ThemeController mockeado
    Get.testMode = true;
    Get.put<ThemeController>(MockThemeController());
  });

  tearDown(() {
    Get.reset(); // Limpia GetX después de cada test
  });

  testWidgets('RecommendedSection renderiza el título y EventList',
      (WidgetTester tester) async {
    // Arrange
    final testUser = User(hash: 'user123', myEvents: []);
    final testEvents = <Event>[]; // Lista vacía para simplicidad

    // Configurar el widget
    await tester.pumpWidget(
      GetMaterialApp(
        translations: TestTranslations(),
        locale: const Locale('en', 'US'),
        home: Scaffold(
          body: RecommendedSection(
            randomEvents: testEvents,
            user: testUser,
          ),
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('Recommended'), findsOneWidget); // Título traducido
    expect(find.byType(EventList), findsOneWidget); // Widget EventList
  });
}