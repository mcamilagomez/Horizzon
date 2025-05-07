// lib/ui/widgets/agenda/day_container.dart
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/ui/widgets/agenda_content/date_helpers.dart';

class DayContainer extends StatelessWidget {
  final Map<String, dynamic> day;
  final DateTime currentDate;
  final DateTime? selectedDate;
  final Function(DateTime) onDaySelected;
  final List<Event> userEvents;

  const DayContainer({
    Key? key,
    required this.day,
    required this.currentDate,
    required this.selectedDate,
    required this.onDaySelected,
    required this.userEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = day['date'] as DateTime;
    final isToday = day['isToday'];
    final isSelected =
        selectedDate != null && DateHelpers.isSameDay(selectedDate!, date);
    final isWeekend = day['weekday'] == 'Sat' || day['weekday'] == 'Sun';
    final hasEvents = DateHelpers.hasEvents(userEvents, date);
    final isCurrentMonth = date.month == currentDate.month;

    return GestureDetector(
      onTap: () => onDaySelected(date),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          width: 60,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.2)
                : isToday
                    ? theme.colorScheme.secondary.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : isToday
                      ? theme.colorScheme.secondary
                      : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day['weekday'],
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isCurrentMonth
                      ? isWeekend
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurface.withOpacity(0.8)
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                  fontWeight: isWeekend ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : isToday
                          ? theme.colorScheme.secondary
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day['day'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : isToday
                              ? theme.colorScheme.onSecondary
                              : isCurrentMonth
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onSurface
                                      .withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              if (hasEvents)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}