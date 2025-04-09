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

  List<Map<String, dynamic>> _getDaysInMonth() {
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
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

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isEventOnDate(Event event, DateTime date) {
    if (_isSameDay(event.initialDate, date)) return true;
    if (_isSameDay(event.initialDate, event.finalDate)) return false;
    return (date.isAfter(event.initialDate) && date.isBefore(event.finalDate)) ||
        _isSameDay(event.finalDate, date);
  }

  List<Event> _getEventsForSelectedDate(List<Event> userEvents) {
    if (_selectedDate == null) return userEvents;
    return userEvents
        .where((event) => _isEventOnDate(event, _selectedDate!))
        .toList();
  }

  bool _hasEvents(List<Event> userEvents, DateTime date) {
    return userEvents.any((event) => _isEventOnDate(event, date));
  }

  double _calculateAverageRating(List<FeedbackbyUser> feedbacks) {
    if (feedbacks.isEmpty) return 0;
    return feedbacks.map((f) => f.stars).reduce((a, b) => a + b) / feedbacks.length;
  }

  Widget _buildEventCard(Event event) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: theme.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Detalles del evento
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      event.cardImageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: theme.dividerColor,
                        child: Icon(Icons.event, color: theme.disabledColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (event.eventTrackName.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              event.eventTrackName,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: theme.textTheme.bodySmall?.color),
                              const SizedBox(width: 4),
                              Text(
                                '${DateFormat('HH:mm').format(event.initialDate)} - ${DateFormat('HH:mm').format(event.finalDate)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: theme.textTheme.bodySmall?.color),
                              const SizedBox(width: 4),
                              Text(event.location, style: theme.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (event.speakers.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: event.speakers.map((speaker) => Chip(
                    label: Text(speaker),
                    backgroundColor: isDark 
                      ? theme.colorScheme.surfaceVariant 
                      : theme.colorScheme.primary.withOpacity(0.1),
                    labelStyle: theme.textTheme.labelSmall?.copyWith(
                      color: isDark 
                        ? theme.colorScheme.onSurfaceVariant 
                        : theme.colorScheme.primary,
                    ),
                  )).toList(),
                ),
              ],
              if (event.feedbacks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      index < _calculateAverageRating(event.feedbacks) 
                        ? Icons.star 
                        : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    )),
                    const SizedBox(width: 4),
                    Text('(${event.feedbacks.length})', style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          TopNavBar(
            mainTitle: "Mi Calendario",
    final currentMonthYear = DateFormat('MMMM y').format(_currentDate);
=======
    final themeController = Get.put(ThemeController());
    final isDark = themeController.isDark.value;
    final theme = Theme.of(context);
    final primary = themeController.color.value;
    final backgroundColor = isDark ? theme.colorScheme.background : Colors.white;
    final currentMonthYear = DateFormat('MMMM y', Get.locale?.languageCode ?? 'es').format(_currentDate);
>>>>>>> Stashed changes
    final daysInMonth = _getDaysInMonth();

    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
<<<<<<< Updated upstream
          // TopNavBar fijo en la parte superior
          const TopNavBar(
            mainTitle: "Agenda",
            subtitle: "Horizzon",
            baseColor: primaryColor,
            shineIntensity: 0.6,
          ),

          
          // Contenido desplazable

=======
          TopNavBar(
            mainTitle: 'calendar.title'.tr,
            subtitle: 'calendar.subtitle'.tr,
            baseColor: primary,
            shineIntensity: 0.6,
          ),
>>>>>>> Stashed changes
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: backgroundColor,
<<<<<<< Updated upstream
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Contenido Home',
                    style: TextStyle(fontSize: 16, color: textColor),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Selector de mes
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: () => _changeMonth(-1),
                                  color: _primaryColor,
                                ),
                                Text(
                                  currentMonthYear,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  onPressed: () => _changeMonth(1),
                                  color: _primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
=======
                child: Consumer<EventController>(
                  builder: (context, controller, child) {
                    final userEvents = controller.user.myEvents;
                    final selectedEvents = _getEventsForSelectedDate(userEvents);
>>>>>>> Stashed changes

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.chevron_left),
                                      onPressed: () => _changeMonth(-1),
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                    Text(
                                      currentMonthYear,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_right),
                                      onPressed: () => _changeMonth(1),
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 90,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: const Icon(Icons.chevron_left),
                                      onPressed: () {
                                        _daysScrollController.animateTo(
                                          _daysScrollController.offset - 100,
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
                                      controller: _daysScrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: daysInMonth.length,
                                      itemBuilder: (context, index) {
                                        final day = daysInMonth[index];
                                        final date = day['date'] as DateTime;
                                        final isToday = day['isToday'];
                                        final isSelected = _selectedDate != null && _isSameDay(_selectedDate!, date);
                                        final isWeekend = day['weekday'] == 'Sat' || day['weekday'] == 'Sun';
                                        final hasEvents = _hasEvents(userEvents, date);

                                        return GestureDetector(
                                          onTap: () => _onDaySelected(date),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: Container(
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? theme.colorScheme.primaryContainer
                                                    : isToday
                                                        ? theme.colorScheme.secondaryContainer
                                                        : isWeekend
                                                            ? theme.colorScheme.surfaceVariant
                                                            : theme.colorScheme.surface,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? theme.colorScheme.primary
                                                      : isToday
                                                          ? theme.colorScheme.secondary
                                                          : theme.colorScheme.outlineVariant,
                                                  width: isSelected || isToday ? 2 : 1,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        day['day'],
                                                        style: theme.textTheme.titleMedium?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: isToday 
                                                              ? theme.colorScheme.error 
                                                              : theme.colorScheme.primary,
                                                        ),
                                                      ),
                                                      Text(
                                                        day['weekday'],
                                                        style: theme.textTheme.bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                  if (hasEvents)
                                                    Positioned(
                                                      top: 4,
                                                      right: 4,
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration: BoxDecoration(
                                                          color: theme.colorScheme.primary,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.chevron_right),
                                      onPressed: () {
                                        _daysScrollController.animateTo(
                                          _daysScrollController.offset + 100,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (_selectedDate != null && selectedEvents.isNotEmpty)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      'calendar.eventsFor'.trParams({
                                        'date': DateFormat('EEEE, d MMMM', Get.locale?.languageCode ?? 'es').format(_selectedDate!)
                                      }),
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  ...selectedEvents.map((event) => _buildEventCard(event)),
                                ],
                              )
                            else if (_selectedDate != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'calendar.noEvents'.tr,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                              )
                            else
                              Column(
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
                                  ...userEvents.map((event) => _buildEventCard(event)),
                                ],
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
