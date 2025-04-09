import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:get/get.dart';
import 'ui/controllers/bottom_nav_controller.dart';
import 'ui/controllers/theme_controller.dart';
import 'ui/controllers/language_controller.dart';
import 'ui/my_app.dart';

void main() {
  runApp(const MyApp());
=======
import 'package:horizzon/ui/controllers/language_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null); // Formato de fecha en español

  final user = User(hash: "123456", myEvents: []);
  
  Get.put(ThemeController()); // Tema dinámico
  Get.put(LanguageController()); // ✅ Añade esto para manejar el idioma

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController(user: user)),
      ],
      child: const MyApp(),
    ),
  );
>>>>>>> Stashed changes
}