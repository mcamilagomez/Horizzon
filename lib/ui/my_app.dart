import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/eventos.dart';
import 'pages/agenda.dart';
import 'pages/ajustes.dart';
import '/ui/controllers/bottom_nav_controller.dart';
import '/ui/controllers/theme_controller.dart';
import '/ui/controllers/language_controller.dart';
import '/ui/translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF2E3A59);

  @override
  Widget build(BuildContext context) {
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
  }
}
