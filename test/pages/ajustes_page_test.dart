import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:horizzon/ui/pages/ajustes.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/controllers/language_controller.dart';

void main() {
  group('AjustesPage Tests', () {
    late ThemeController themeController;
    late LanguageController languageController;

    setUp(() {
      themeController = ThemeController();
      languageController = LanguageController();
      Get.put(themeController);
      Get.put(languageController);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Muestra la estructura básica de ajustes', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AjustesPage()));

      expect(find.text('settings'.tr), findsOneWidget);
      expect(find.byType(ListTile), findsAtLeastNWidgets(5));
    });

    testWidgets('Cambia el tema claro/oscuro', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AjustesPage()));

      final initialBrightness = themeController.isDark.value;
      final switchFinder = find.byType(Switch).first;

      await tester.tap(switchFinder);
      await tester.pump();

      expect(themeController.isDark.value, isNot(equals(initialBrightness)));
    });

    testWidgets('Muestra diálogo de cambio de idioma', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AjustesPage()));

      await tester.tap(find.text('change_language'.tr));
      await tester.pumpAndSettle();

      expect(find.text('select_language'.tr), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('Muestra diálogo de cierre de sesión', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AjustesPage()));

      await tester.tap(find.text('logout'.tr));
      await tester.pumpAndSettle();

      expect(find.text('logout_confirm'.tr), findsOneWidget);
    });
  });
}