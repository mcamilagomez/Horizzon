// lib/ui/widgets/agenda/event_list_section.dart
import 'package:flutter/material.dart';
import 'package:horizzon/ui/widgets/recomended/event_card.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

class EventListSection extends StatelessWidget {
  final DateTime? selectedDate;
  final List<Event> selectedEvents;
  final List<Event> userEvents;
  final User user;

  const EventListSection({
    Key? key,
    required this.selectedDate,
    required this.selectedEvents,
    required this.userEvents,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Theme.of(context).colorScheme.primary; // Usar el color primario del tema
    
    if (selectedDate != null && selectedEvents.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'calendar.eventsFor'.trParams({
                'date': DateFormat(
                        'EEEE, d MMMM',
                        Get.locale?.languageCode ?? 'es')
                    .format(selectedDate!)
              }),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ...selectedEvents.map((event) => EventCard(event: event, user: user, colorPrincipal: primaryColor)), // Usar color primario
        ],
      );
    } else if (selectedDate != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'calendar.noEvents'.tr,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'calendar.allEvents'.tr,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...userEvents.map((event) => EventCard(event: event, user: user, colorPrincipal: primaryColor)), // Usar color primario
        ],
      );
    }
  }
}