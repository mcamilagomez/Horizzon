// ui/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ui/controllers/navigation_controller.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        children: [
          // AppBar 
          Container(
            color: Colors.blue[900],
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 16.0,
              right: 16.0,
              bottom: 0.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  'images/logo.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: double.infinity,
                child: const Center(child: Text('Contenido Home')),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}