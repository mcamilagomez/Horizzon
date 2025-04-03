// ui/my_app.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ui/controllers/navigation_controller.dart';
import 'pages/home.dart';
import 'pages/eventos.dart';
import 'pages/agenda.dart';
import 'pages/ajustes.dart';
import '/ui/controllers/bottom_nav_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController()); // Registra el controlador

    return GetMaterialApp(
      title: 'Mi Aplicación',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition, // <- Global
      transitionDuration: Duration.zero,  
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage(), transition: Transition.noTransition,),
        GetPage(name: '/eventos', page: () => EventosPage(), transition: Transition.noTransition,),
        GetPage(name: '/agenda', page: () => AgendaPage(), transition: Transition.noTransition,),
        GetPage(name: '/ajustes', page: () => AjustesPage(), transition: Transition.noTransition,),
      ],
    );
  }
}