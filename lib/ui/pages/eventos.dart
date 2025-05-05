import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/entities/user.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../controllers/theme_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';
import 'package:horizzon/ui/widgets/eventos_content/event_track_eventos.dart';
import 'package:horizzon/ui/widgets/recomended/event_card.dart';

class EventosPage extends StatefulWidget {
  final User user;

  const EventosPage({super.key, required this.user});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  final Map<int, bool> _expandedTracks = {};
  final ThemeController themeController = Get.find<ThemeController>();
  late final Master master;

  final Key stateKey = const Key('EventosPageState');
  @override
  void initState() {
    super.initState();
    for (var track in master.eventTracks) {
      _expandedTracks[track.id] = false;
    }
  }

  void _toggleTrackExpansion(int trackId) {
    setState(() {
      _expandedTracks[trackId] = !(_expandedTracks[trackId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDark.value;
      final primaryColor = themeController.color.value;
      final backgroundColor = isDark ? const Color(0xFF1B1B1D) : Colors.white;

      return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            TopNavBar(
              mainTitle: "eventTracksTitle".tr,
              subtitle: "Horizzon",
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "allEvents".tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: master.eventTracks.length,
                          itemBuilder: (context, trackIndex) {
                            final track = master.eventTracks[trackIndex];
                            return EventTrackCard(
                              track: track,
                              isExpanded: _expandedTracks[track.id] ?? false,
                              primaryColor: primaryColor,
                              isDark: isDark,
                              user: widget.user,
                              onToggleExpand: _toggleTrackExpansion,
                            );
                          },
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
    });
  }
}
