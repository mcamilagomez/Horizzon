import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'event_pill.dart';

class EventPillsList extends StatelessWidget {
  final List<Event> events;
  final Color colorPrincipal;

  const EventPillsList({
    super.key,
    required this.events,
    required this.colorPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text(
            'No tienes recordatorios aún',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventPill(
            event: events[index],
            colorPrincipal: colorPrincipal,
          );
        },
      ),
    );
  }
}
