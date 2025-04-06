import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const TopNavBar(
            mainTitle: "Líneas de Eventos",
            subtitle: "Horizzon",
            baseColor: primaryColor,
            shineIntensity: 0.6,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: backgroundColor,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Contenido eventos',
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
