import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: const Center(child: Text('Contenido de Ajustes')),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}