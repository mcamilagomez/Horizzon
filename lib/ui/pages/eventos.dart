import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/master.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/event_list.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final master = Master.createWithSampleData();
    final primaryColor = const Color.fromRGBO(18, 37, 98, 1);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const TopNavBar(
            mainTitle: "Líneas de Eventos",
            subtitle: "Horizzon",
            baseColor: Color.fromRGBO(18, 37, 98, 1),
            shineIntensity: 0.6,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: master.eventTracks.length,
                  itemBuilder: (context, trackIndex) {
                    final track = master.eventTracks[trackIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            track.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        EventList(
                          events: track.events,
                          primaryColor: primaryColor,
                        ),
                        if (trackIndex != master.eventTracks.length - 1)
                          const Divider(height: 40),
                      ],
                    );
                  },
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
