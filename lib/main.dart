import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:horizzon/ui/my_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_CO', null); // Formato de fecha en español

  final user = User(hash: "123456", myEvents: []);

  // Inyección de dependencias
  Get.put(ThemeController()); // Tema dinámico
  Get.put(LanguageController()); // Controlador de idioma

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController(user: user)),
      ],
      child: const MyApp(),
    ),
  );
}
