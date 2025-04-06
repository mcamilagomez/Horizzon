import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../controllers/theme_controller.dart';
import '../controllers/language_controller.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);
  static const Color darkBackground = Color(0xFF1C1C2D);
  static const Color lightBackground = Colors.white;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          TopNavBar(
            mainTitle: 'settings'.tr,
            subtitle: "Horizzon",
            baseColor: primaryColor,
            shineIntensity: 0.6,
          ),
          Expanded(
            child: Obx(() {
              final isDark = themeController.isDark.value;
              final backgroundColor = isDark ? darkBackground : lightBackground;
              final textColor = isDark ? Colors.white : Colors.black87;
              final dividerColor = isDark ? Colors.white24 : Colors.grey.shade300;

              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  color: backgroundColor,
                  width: double.infinity,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ListTile(
                        leading: Icon(Icons.language, color: primaryColor),
                        title: Text('change_language'.tr, style: TextStyle(color: textColor)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: backgroundColor,
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
                      ),
                      Divider(color: dividerColor),
                      ListTile(
                        leading: Icon(Icons.notifications, color: primaryColor),
                        title: Text('notifications'.tr, style: TextStyle(color: textColor)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
                        onTap: () {
                          Get.snackbar('notifications'.tr, 'notifications_msg'.tr,
                              backgroundColor: backgroundColor,
                              colorText: textColor);
                        },
                      ),
                      Divider(color: dividerColor),
                      ListTile(
                        leading: Icon(Icons.color_lens, color: primaryColor),
                        title: Text(
                          themeController.isDark.value ? 'dark_mode'.tr : 'light_mode'.tr,
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Switch(
                          value: themeController.isDark.value,
                          onChanged: (val) => themeController.toggleTheme(),
                          activeColor: primaryColor,
                        ),
                      ),
                      Divider(color: dividerColor),
                      ListTile(
                        leading: Icon(Icons.lock, color: primaryColor),
                        title: Text('privacy'.tr, style: TextStyle(color: textColor)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
                        onTap: () {
                          Get.snackbar('privacy'.tr, 'privacy_msg'.tr,
                              backgroundColor: backgroundColor,
                              colorText: textColor);
                        },
                      ),
                      Divider(color: dividerColor),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text('logout'.tr, style: const TextStyle(color: Colors.red)),
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: backgroundColor,
                            titleStyle: TextStyle(color: textColor),
                            title: 'logout'.tr,
                            content: Text('logout_confirm'.tr, style: TextStyle(color: textColor)),
                            confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                              onPressed: () {
                                Get.back();
                                Get.offAllNamed('/home');
                              },
                              child: Text('yes'.tr),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: Text('cancel'.tr, style: TextStyle(color: primaryColor)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
