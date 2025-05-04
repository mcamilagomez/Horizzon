import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'reminders_section.dart';
import 'recommended_section.dart';

class HomeContent extends StatelessWidget {
  final List<Event> randomEvents;
  final User user;

  const HomeContent({
    super.key,
    required this.randomEvents,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    final backgroundColor = isDark ? const Color(0xFF1B1B1D) : Colors.white;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        color: backgroundColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RemindersSection(user: user),
            const SizedBox(height: 20),
            Expanded(child: RecommendedSection(randomEvents: randomEvents, user: user)),
          ],
        ),
      ),
    );
  }
}