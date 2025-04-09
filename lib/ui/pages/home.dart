import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:provider/provider.dart';

import '../controllers/event_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/event_list.dart';
import '../widgets/event_pills_list.dart';

import 'dart:math'; // Import for Random

class HomePage extends StatefulWidget {
  final Master master;
  final User user;

  const HomePage({
    super.key,
    required this.master,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Event> randomEvents;

  @override
  void initState() {
    super.initState();
    randomEvents = _getRandomEvents(widget.master.eventTracks, 20);
  }

  List<Event> _getRandomEvents(List<EventTrack> eventTracks, int count) {
    final allEvents = eventTracks.expand((track) => track.events).toList();
    allEvents.shuffle(Random());
    return allEvents.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    final primaryColor = themeController.color.value;
    final backgroundColor = isDark ? const Color(0xFF1B1B1D) : Colors.white;
    final textColor = isDark ? Colors.white : primaryColor;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          TopNavBar(
            mainTitle: "app.title".tr,
            subtitle: "home.subtitle".tr,
            baseColor: primaryColor,
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
                width: double.infinity,
                child: Column(
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
                          user: widget.user,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                        events: randomEvents, // Using random events
                        primaryColor: primaryColor,
                        user: widget.user,
                      ),
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
  }
}
