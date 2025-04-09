import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../controllers/theme_controller.dart';
import '../controllers/language_controller.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  final List<Color> colorOptions = const [
    Color.fromRGBO(18, 37, 98, 1), // Azul predeterminado
    Colors.teal,
    Colors.deepOrange,
    Colors.green,
    Colors.deepPurple,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final LanguageController languageController = Get.put(LanguageController());

    return Obx(() {
      final isDark = themeController.isDark.value;
      final primary = themeController.color.value;

      final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF6F7FB);
      final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
      final textColor = isDark ? Colors.white : Colors.black87;
      final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;
      final dividerColor = isDark ? Colors.white24 : Colors.grey.shade300;

      return Scaffold(
        backgroundColor: primary,
        body: Column(
          children: [
            TopNavBar(
              mainTitle: 'settings'.tr,
              subtitle: "Horizzon",
              baseColor: primary,
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
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildTile(
                        icon: Icons.language,
                        title: 'change_language'.tr,
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: cardColor,
                            titleStyle: TextStyle(color: textColor),
                            title: 'select_language'.tr,
                            content: Column(
                              children: [
                                ListTile(
                                  title: Text('Español', style: TextStyle(color: textColor)),
                                  onTap: () {
                                    languageController.changeLanguage('es');
                                    Get.back();
                                  },
                                ),
                                ListTile(
                                  title: Text('English', style: TextStyle(color: textColor)),
                                  onTap: () {
                                    languageController.changeLanguage('en');
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        primary: primary,
                        textColor: textColor,
                        dividerColor: dividerColor,
                      ),
                      _buildTile(
                        icon: Icons.notifications,
                        title: 'notifications'.tr,
                        onTap: () {
                          Get.snackbar(
                            'notifications'.tr,
                            'notifications_msg'.tr,
                            backgroundColor: cardColor,
                            colorText: textColor,
                          );
                        },
                        primary: primary,
                        textColor: textColor,
                        dividerColor: dividerColor,
                      ),
                      _buildColorPickerTile(primary, textColor, subtitleColor, dividerColor, themeController),
                      _buildThemeSwitcherTile(isDark, textColor, primary, dividerColor, themeController),
                      _buildTile(
                        icon: Icons.lock,
                        title: 'privacy'.tr,
                        onTap: () {
                          Get.snackbar(
                            'privacy'.tr,
                            'privacy_msg'.tr,
                            backgroundColor: cardColor,
                            colorText: textColor,
                          );
                        },
                        primary: primary,
                        textColor: textColor,
                        dividerColor: dividerColor,
                      ),
                      Divider(color: dividerColor),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text('logout'.tr, style: const TextStyle(color: Colors.red)),
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: cardColor,
                            titleStyle: TextStyle(color: textColor),
                            title: 'logout'.tr,
                            content: Text('logout_confirm'.tr, style: TextStyle(color: textColor)),
                            confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primary),
                              onPressed: () {
                                Get.back();
                                Get.offAllNamed('/home');
                              },
                              child: Text('yes'.tr),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: Text('cancel'.tr, style: TextStyle(color: primary)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color primary,
    required Color textColor,
    required Color dividerColor,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: primary),
          title: Text(title, style: TextStyle(color: textColor)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
          onTap: onTap,
        ),
        Divider(color: dividerColor),
      ],
    );
  }

  Widget _buildColorPickerTile(
    Color primary,
    Color textColor,
    Color subtitleColor,
    Color dividerColor,
    ThemeController themeController,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.color_lens, color: primary),
          title: Text('primary_color'.tr, style: TextStyle(color: textColor)),
          subtitle: Row(
            children: colorOptions.map((color) {
              return GestureDetector(
                onTap: () => themeController.setColor(color), // Cambio a setColor
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 6),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color == primary ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Divider(color: dividerColor),
      ],
    );
  }

  Widget _buildThemeSwitcherTile(
    bool isDark,
    Color textColor,
    Color primary,
    Color dividerColor,
    ThemeController themeController,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.dark_mode, color: primary),
          title: Text(
            isDark ? 'dark_mode'.tr : 'light_mode'.tr,
            style: TextStyle(color: textColor),
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (_) => themeController.toggleTheme(),
            activeColor: primary,
          ),
        ),
        Divider(color: dividerColor),
      ],
    );
  }
}
