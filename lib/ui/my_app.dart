// ui/my_app.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'pages/home.dart';
import 'pages/eventos.dart';
import 'pages/agenda.dart';
import 'pages/ajustes.dart';
import '/ui/controllers/bottom_nav_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Crear las instancias que se compartirán
    final master = Master.createWithSampleData();
    final user = User(hash: "123456", myEvents: []);

    // Registrar el controlador y las instancias
    Get.put(BottomNavController());
    Get.put(master);
    Get.put(user);

    return GetMaterialApp(
      title: 'Mi Aplicación',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration.zero,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
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
          page: () => AgendaPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/ajustes',
          page: () => AjustesPage(),
          transition: Transition.noTransition,
        ),
      ],
    );
  }
}
