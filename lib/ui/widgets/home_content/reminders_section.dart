import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:provider/provider.dart';

import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/widgets/reminders/event_pills_list.dart';

class RemindersSection extends StatelessWidget { 
  final User user;

  const RemindersSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    final primaryColor = themeController.color.value;
    final textColor = isDark ? Colors.white : primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            'home.reminders'.tr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        Consumer<EventController>(
          builder: (context, controller, _) {
            return EventPillsList(
              events: controller.user.myEvents,
              colorPrincipal: primaryColor,
              user: user,
            );
          },
        ),
      ],
    );
  }
}
