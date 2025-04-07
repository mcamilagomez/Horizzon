import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/event_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color primaryColor = Color.fromRGBO(18, 37, 98, 1);

  @override
  Widget build(BuildContext context) {
    // Ahora creamos el Master directamente usando el factory constructor
    final master = Master.createWithSampleData();
    final user = User(hash: "123456", myEvents: []);

    final events = master.eventTracks.first.events;
    final primaryColor = const Color.fromRGBO(18, 37, 98, 1);


    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const TopNavBar(
            mainTitle: "Horizzon",
            subtitle: "'Un nuevo evento en el horizonte'",
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
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: Text(
                        'Recomendados',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                    Expanded(
                      child: EventList(
                        events: events,
                        primaryColor: primaryColor,
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
