import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/event_card.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final Color primaryColor;
  final User user;

  const EventList({
    super.key,
    required this.events,
    required this.primaryColor,
    required this.user,
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
          user: user,
        );
      },
    );
  }
}
