// ui/pages/events_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos')),
      body: const Center(child: Text('Contenido de Eventos')),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}