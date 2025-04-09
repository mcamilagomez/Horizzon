import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/theme_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController navController = Get.find();
    final ThemeController themeController = Get.find();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final primaryColor = themeController.color.value;

      return BottomNavigationBar(
        currentIndex: navController.currentIndex.value,
        onTap: navController.changePage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: isDark ? Colors.grey[400] : Colors.blue[900],
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
      );
    });
  }
}
