import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/ui/my_app.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/pages/home.dart';
import 'package:horizzon/ui/widgets/bottom_nav_bar.dart';
import 'package:horizzon/ui/widgets/top_nav_bar.dart';
import '../test/mock/mock_data.dart';
import '../test/mock/repository_mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test con mocks', () {
    final mockUserRepo = MockUserRepository();
    final mockMasterRepo = MockMasterRepository();
    final mockUser = MockData.getMockUser();
    final mockMaster = MockData.getMockMaster();

    testWidgets('Verificar inicio de la aplicación con datos simulados', 
      (WidgetTester tester) async {
      // Inicializar controladores de GetX
      final themeController = ThemeController();
      final languageController = LanguageController();
      
      Get.put(themeController);
      Get.put(languageController);
      
      // Construir la aplicación con los repositorios simulados
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider.value(value: mockUserRepo),
            Provider.value(value: mockMasterRepo),
            ChangeNotifierProvider(
              create: (_) => EventController(
                user: mockUser,
                userRepo: mockUserRepo,
                masterRepo: mockMasterRepo,
              ),
            ),
          ],
          child: MyApp(user: mockUser, master: mockMaster),
        ),
      );
      
      // Esperar a que la aplicación se cargue completamente
      await tester.pumpAndSettle();
      
      // Verificar que la HomePage se ha construido
      expect(find.byType(HomePage), findsOneWidget);
      
      // Verificar que los componentes principales están presentes
      expect(find.byType(TopNavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      
      // Verificar que se muestra el evento de prueba
      expect(find.text('Evento de prueba 1'), findsOneWidget);
      
      // Probar interacciones básicas como scrolling
      await tester.drag(find.byType(ListView).first, const Offset(0, -300));
      await tester.pumpAndSettle();
      
      // Si tienes un botón específico en tu HomeContent, puedes probarlo
      // Por ejemplo, si tienes un botón para ver detalles del evento:
      final eventTile = find.text('Evento de prueba 1');
      if (eventTile.evaluate().isNotEmpty) {
        await tester.tap(eventTile);
        await tester.pumpAndSettle();
        
        // Verificar que se muestra la página de detalles
        // Ejemplo: expect(find.text('Detalles del evento'), findsOneWidget);
        
        // Volver atrás
        await tester.pageBack();
        await tester.pumpAndSettle();
      }
    });
  });
}