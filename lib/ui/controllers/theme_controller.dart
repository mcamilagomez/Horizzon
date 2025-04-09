import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  var color = const Color.fromRGBO(18, 37, 98, 1).obs; // Color inicial

  @override
  void onInit() {
    _updateTheme(); // Establecer el tema inicial al iniciar
    super.onInit();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _updateTheme();
  }
<<<<<<< Updated upstream
=======

  void changeColor(Color newColor) {
    color.value = newColor;
    _updateTheme();
  }

  void _updateTheme() {
    final newTheme = ThemeData(
      brightness: isDark.value ? Brightness.dark : Brightness.light,
      primaryColor: color.value,
      scaffoldBackgroundColor: isDark.value ? const Color(0xFF1C1C2D) : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: color.value,
        foregroundColor: Colors.white,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: color.value,
        brightness: isDark.value ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );

    Get.changeTheme(newTheme);
  }
>>>>>>> Stashed changes
}
