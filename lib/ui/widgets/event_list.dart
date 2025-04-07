// widgets/event_list.dart
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final Color primaryColor;

  const EventList({
    super.key,
    required this.events,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(
          event: events[index],
          colorPrincipal: primaryColor,
        );
      },
    );
  }
}
