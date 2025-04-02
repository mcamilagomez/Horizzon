import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de tener GetX en tus dependencias

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
                child: _getPage(_currentIndex), 
              ),
            ),
          ),
        ],
      ),
      
      // NavBar inferior solo con iconos
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
      
            _navigateToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue[900],
          unselectedItemColor: Colors.blue[900],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 24,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 20),
              activeIcon: Icon(Icons.home, size: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_outlined, size: 20),
              activeIcon: Icon(Icons.event, size: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined, size: 20),
              activeIcon: Icon(Icons.calendar_today, size: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 20),
              activeIcon: Icon(Icons.settings, size: 20),
              label: '',
            ),
          ],
        ),
      ),
    );
  }


  void _navigateToPage(int index) {
    switch(index) {
      case 0:
        Get.offNamed("/home");
        break;
      case 1:
        Get.offNamed("/eventos");
        break;
      case 2:
        Get.offNamed("/agenda");
        break;
      case 3:
        Get.offNamed("/ajustes");
        break;
    }
  }

  // Método para obtener la página actual
  Widget _getPage(int index) {
    switch(index) {
      case 0:
        return const Center(child: Text('Contenido Home')); 
      case 1:
        return const Center(child: Text('Contenido Eventos')); 
      case 2:
        return const Center(child: Text('Contenido Agenda')); 
      case 3:
        return const Center(child: Text('Contenido Ajustes')); 
      default:
        return const Center(child: Text('Página no encontrada'));
    }
  }
}