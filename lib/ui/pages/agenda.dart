// lib/ui/pages/agenda_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/agenda_content/month_selector.dart';
import 'package:horizzon/ui/widgets/agenda_content/day_calendar_strip.dart';
import 'package:horizzon/ui/widgets/agenda_content/event_list_section.dart';
import 'package:horizzon/ui/widgets/agenda_content/date_helpers.dart';

class AgendaPage extends StatefulWidget {
  final User user;

  const AgendaPage({super.key, required this.user});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  final ScrollController _daysScrollController = ScrollController();

  void _changeMonth(int delta) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + delta);
      _selectedDate = null;
    });
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  List<Map<String, dynamic>> _getDaysInMonth() {
    final lastDay = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final today = DateTime.now();

    return List.generate(lastDay.day, (index) {
      final day = index + 1;
      final date = DateTime(_currentDate.year, _currentDate.month, day);
      return {
        'day': day.toString(),
        'weekday': DateFormat('E', Get.locale?.languageCode).format(date),
        'isToday': today.year == _currentDate.year &&
            today.month == _currentDate.month &&
            today.day == day,
        'date': date,
      };
    });
  }

  List<Event> _getEventsForSelectedDate(List<Event> userEvents) {
    if (_selectedDate == null) return userEvents;
    return userEvents
        .where((event) => DateHelpers.isEventOnDate(event, _selectedDate!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    final isDark = themeController.isDark.value;
    final theme = Theme.of(context);
    final primary = themeController.color.value;
    final backgroundColor = isDark ? theme.colorScheme.background : Colors.white;
    final daysInMonth = _getDaysInMonth();

    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          TopNavBar(
            mainTitle: 'calendar.title'.tr,
            subtitle: 'calendar.subtitle'.tr,
            baseColor: primary,
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
                child: Consumer<EventController>(
                  builder: (context, controller, child) {
                    final userEvents = controller.user.myEvents;
                    final selectedEvents = _getEventsForSelectedDate(userEvents);

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            MonthSelector(
                              currentDate: _currentDate,
                              onChangeMonth: _changeMonth,
                              themeData: theme,
                            ),
                            const SizedBox(height: 20),
                            DayCalendarStrip(
                              daysInMonth: daysInMonth,
                              currentDate: _currentDate,
                              selectedDate: _selectedDate,
                              scrollController: _daysScrollController,
                              onDaySelected: _onDaySelected,
                              userEvents: userEvents,
                            ),
                            const SizedBox(height: 20),
                            EventListSection(
                              selectedDate: _selectedDate,
                              selectedEvents: selectedEvents,
                              userEvents: userEvents,
                              user: widget.user,
                            ),
                          ],
                        ),
                      ),
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