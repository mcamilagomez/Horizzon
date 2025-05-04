import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';

import 'package:horizzon/ui/widgets/bottom_nav_bar.dart';
import 'package:horizzon/ui/widgets/home_content/home_content.dart';
import 'package:horizzon/ui/widgets/top_nav_bar.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'dart:math';
import 'package:horizzon/ui/controllers/theme_controller.dart';

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
    return Scaffold(
      backgroundColor: Get.find<ThemeController>().color.value,
      body: Column(
        children: [
          TopNavBar(
            mainTitle: "app.title".tr,
            subtitle: "home.subtitle".tr,
            baseColor: Get.find<ThemeController>().color.value,
            shineIntensity: 0.6,
          ),
          Expanded(
            child: HomeContent(
              randomEvents: randomEvents,
              user: widget.user,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}