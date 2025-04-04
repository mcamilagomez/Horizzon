import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart'; 

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 37, 98, 1),
      body: Column(
        children: [
          const TopNavBar(
            mainTitle: "Líneas de Eventos",
            subtitle: "Horizzon",
            baseColor: Color.fromRGBO(18, 37, 98, 1),
            shineIntensity: 0.6,
          ),
          
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: const Center(child: Text('Contenido eventos')),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}