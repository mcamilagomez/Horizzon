import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  var color = const Color.fromRGBO(18, 37, 98, 1).obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void setColor(Color newColor) {
    color.value = newColor;
    // Si usas temas personalizados, puedes actualizar Get.changeTheme también.
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: color.value,
        colorScheme: ColorScheme.light(
          primary: color.value,
          onPrimary: Colors.white,
          secondary: Colors.amber,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: color.value,
        colorScheme: ColorScheme.dark(
          primary: color.value,
          onPrimary: Colors.white,
          secondary: Colors.amber,
        ),
      );
}
