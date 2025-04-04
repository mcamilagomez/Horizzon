import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();
    
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: controller.changePage,
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
    ));
  }
}
