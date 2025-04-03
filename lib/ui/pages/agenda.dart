import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: const Center(child: Text('Contenido de Agenda')),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}