import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< Updated upstream
import 'pages/home.dart';
import 'pages/eventos.dart';
import 'pages/agenda.dart';
import 'pages/ajustes.dart';
import '/ui/controllers/bottom_nav_controller.dart';
import '/ui/controllers/theme_controller.dart';
import '/ui/controllers/language_controller.dart';
import '/ui/translations.dart';
=======
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/bottom_nav_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/pages/home.dart';
import 'package:horizzon/ui/pages/eventos.dart';
import 'package:horizzon/ui/pages/agenda.dart';
import 'package:horizzon/ui/pages/ajustes.dart';
import 'package:horizzon/ui/translations.dart';
>>>>>>> Stashed changes

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF2E3A59);

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    final themeController = Get.put(ThemeController());
    final languageController = Get.put(LanguageController());
    Get.put(BottomNavController());

    return Obx(() => GetMaterialApp(
          title: 'Mi Aplicación',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          transitionDuration: Duration.zero,
          themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            iconTheme: const IconThemeData(color: primaryColor),
            dividerColor: Colors.grey.shade300,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: darkBackground,
            cardColor: darkCard,
            appBarTheme: const AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            dividerColor: Colors.grey.shade700,
          ),
          translations: AppTranslations(),
          locale: languageController.locale.value,
          fallbackLocale: const Locale('es', 'ES'),
          initialRoute: '/home',
          getPages: [
            GetPage(name: '/home', page: () => HomePage(), transition: Transition.noTransition),
            GetPage(name: '/eventos', page: () => EventosPage(), transition: Transition.noTransition),
            GetPage(name: '/agenda', page: () => AgendaPage(), transition: Transition.noTransition),
            GetPage(name: '/ajustes', page: () => AjustesPage(), transition: Transition.noTransition),
          ],
        ));
=======
    final master = Master.createWithSampleData();
    final user = User(hash: "123456", myEvents: []);

    // Registra los controladores
    Get.put(BottomNavController());
    Get.put(LanguageController());
    Get.put(master);
    Get.put(user);

    return GetBuilder<LanguageController>(
      builder: (languageController) {
        return GetMaterialApp(
          title: 'Horizzon',
          debugShowCheckedModeBanner: false,
          
          // Configuración de internacionalización
          translations: AppTranslations(),
          locale: languageController.getLocale, // Usa el locale del controlador
          fallbackLocale: const Locale('es', 'ES'),
          
          // Configuración de rutas
          initialRoute: '/home',
          defaultTransition: Transition.noTransition,
          transitionDuration: Duration.zero,
          getPages: [
            GetPage(
              name: '/home',
              page: () => HomePage(master: master, user: user),
              transition: Transition.noTransition,
            ),
            GetPage(
              name: '/eventos',
              page: () => EventosPage(user: user),
              transition: Transition.noTransition,
            ),
            GetPage(
              name: '/agenda',
              page: () => AgendaPage(user: user),
              transition: Transition.noTransition,
            ),
            GetPage(
              name: '/ajustes',
              page: () => AjustesPage(),
              transition: Transition.noTransition,
            ),
          ],
          
          // Configuración del tema
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(18, 37, 98, 1),
              onPrimary: Colors.white,
              secondary: Color(0xFFff9800),
              onSecondary: Colors.black,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
              error: Colors.red,
              onError: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
>>>>>>> Stashed changes
  }
}