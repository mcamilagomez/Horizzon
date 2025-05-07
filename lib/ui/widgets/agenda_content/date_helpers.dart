// lib/ui/helpers/date_helpers.dart
import 'package:horizzon/domain/entities/event.dart';

class DateHelpers {
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isEventOnDate(Event event, DateTime date) {
    if (isSameDay(event.initialDate, date)) return true;
    if (isSameDay(event.initialDate, event.finalDate)) return false;
    return (date.isAfter(event.initialDate) && date.isBefore(event.finalDate) ||
        isSameDay(event.finalDate, date));
  }

  static bool hasEvents(List<Event> userEvents, DateTime date) {
    return userEvents.any((event) => isEventOnDate(event, date));
  }

  static double calculateAverageRating(List<FeedbackbyUser> feedbacks) {
    if (feedbacks.isEmpty) return 0;
    return feedbacks.map((f) => f.stars).reduce((a, b) => a + b) /
        feedbacks.length;
  }
}