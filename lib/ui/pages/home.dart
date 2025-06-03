import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/use_case/use_case.dart';

import 'package:horizzon/ui/widgets/bottom_nav_bar.dart';
import 'package:horizzon/ui/widgets/home_content/home_content.dart';
import 'package:horizzon/ui/widgets/top_nav_bar.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';

import 'dart:math';

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
  List<Event> randomEvents = [];

  @override
  void initState() {
    super.initState();
    _refreshAndLoadEvents();
  }

  Future<void> _refreshAndLoadEvents() async {
    final appInit = Get.find<AppInitializationUseCase>();
    await appInit.refreshMasterData();

    if (!mounted) return;

    final Master updatedMaster = appInit.master;
    final List<Event> updatedEvents =
        _getRandomEvents(updatedMaster.eventTracks, 20);

    setState(() {
      randomEvents = updatedEvents;
    });

    print("✅ Se hizo refresh de master desde HomePage");
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
