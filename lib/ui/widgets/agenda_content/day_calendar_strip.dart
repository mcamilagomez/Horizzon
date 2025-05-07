// lib/ui/widgets/agenda/day_calendar_strip.dart
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/ui/widgets/agenda_content/date_helpers.dart';
import 'package:horizzon/ui/widgets/agenda_content/day_container.dart';

class DayCalendarStrip extends StatelessWidget {
  final List<Map<String, dynamic>> daysInMonth;
  final DateTime currentDate;
  final DateTime? selectedDate;
  final ScrollController scrollController;
  final Function(DateTime) onDaySelected;
  final List<Event> userEvents;

  const DayCalendarStrip({
    Key? key,
    required this.daysInMonth,
    required this.currentDate,
    required this.selectedDate,
    required this.scrollController,
    required this.onDaySelected,
    required this.userEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.offset - 100,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              color: theme.colorScheme.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth.length,
              itemBuilder: (context, index) {
                final day = daysInMonth[index];
                return DayContainer(
                  day: day,
                  currentDate: currentDate,
                  selectedDate: selectedDate,
                  onDaySelected: onDaySelected,
                  userEvents: userEvents,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.offset + 100,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}