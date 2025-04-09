import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/controllers/bottom_nav_controller.dart';
import 'package:horizzon/ui/pages/home.dart';
import 'package:horizzon/ui/pages/eventos.dart';
import 'package:horizzon/ui/pages/agenda.dart';
import 'package:horizzon/ui/pages/ajustes.dart';
import 'package:horizzon/ui/translations.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF2E3A59);

  @override
  Widget build(BuildContext context) {
    final master = Master.createWithSampleData();
    final user = User(hash: "123456", myEvents: []);

    // Registrar los controladores
    Get.put(BottomNavController());
    Get.put(LanguageController());
    Get.put(ThemeController());

    return Obx(() {
      final themeController = Get.find<ThemeController>();
      final languageController = Get.find<LanguageController>();

      return GetMaterialApp(
        title: 'Mi Aplicación',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: Duration.zero,
        themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          iconTheme: const IconThemeData(color: primaryColor),
          dividerColor: Colors.grey.shade300,
          textTheme: GoogleFonts.josefinSansTextTheme(
            Theme.of(context).textTheme,
          ),
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
          GetPage(name: '/home', page: () => HomePage(master: master, user: user)),
          GetPage(name: '/eventos', page: () => EventosPage(user: user)),
          GetPage(name: '/agenda', page: () => AgendaPage(user: user)),
          GetPage(name: '/ajustes', page: () => AjustesPage()),
        ],
      );
    });
  }
}
