import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  var locale = const Locale('es', 'ES').obs;

  void changeLanguage(String langCode) {
    if (langCode == 'en') {
      locale.value = const Locale('en', 'US');
    } else {
      locale.value = const Locale('es', 'ES');
    }
    Get.updateLocale(locale.value);
  }
}