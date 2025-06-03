import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../controllers/theme_controller.dart';
import 'package:horizzon/ui/widgets/eventos_content/event_track_eventos.dart';
import 'package:horizzon/domain/use_case/use_case.dart';

class EventosPage extends StatefulWidget {
  final User user;
  final Master master;
  const EventosPage({super.key, required this.user, required this.master});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  final Map<int, bool> _expandedTracks = {};
  final ThemeController themeController = Get.find<ThemeController>();

  Master? _master;

  @override
  void initState() {
    super.initState();
    _master = widget.master;
    _initializeExpansionStates(_master!);

    _refreshMaster(); // ✅ Refrescar al cargar
  }

  void _initializeExpansionStates(Master master) {
    for (var track in master.eventTracks) {
      _expandedTracks.putIfAbsent(track.id, () => false);
    }
  }

  Future<void> _refreshMaster() async {
    final appInit = Get.find<AppInitializationUseCase>();
    await appInit.refreshMasterData();

    if (!mounted) return;

    setState(() {
      _master = appInit.master;
      _initializeExpansionStates(_master!);
    });

    print("✅ Se hizo refresh de master desde EventosPage");
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
                  child: _master == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(24, 24, 24, 16),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                itemCount: _master!.eventTracks.length,
                                itemBuilder: (context, index) {
                                  final track = _master!.eventTracks[index];
                                  return EventTrackCard(
                                    track: track,
                                    isExpanded:
                                        _expandedTracks[track.id] ?? false,
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
