import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/widgets/event_list.dart';

class RecommendedSection extends StatelessWidget {
  final List<Event> randomEvents;
  final User user;

  const RecommendedSection({
    super.key,
    required this.randomEvents,
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
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            'home.recommended'.tr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        Expanded(
          child: EventList(
            events: randomEvents,
            primaryColor: primaryColor,
            user: user,
          ),
        ),
      ],
    );
  }
}