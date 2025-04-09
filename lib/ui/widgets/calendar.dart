import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/event.dart';

class Calendar extends StatefulWidget {
  final List<Event> myEvents;
  final Color primaryColor;

  const Calendar({
    super.key,
    required this.myEvents,
    this.primaryColor = const Color.fromRGBO(18, 37, 98, 1),
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  void _changeMonth(int delta) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + delta);
      _selectedDate = null;
    });
  }

  List<DateTime> _getDaysInMonth() {
    final first = DateTime(_currentDate.year, _currentDate.month, 1);
    final last = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    return List.generate(
      last.day,
      (index) => DateTime(_currentDate.year, _currentDate.month, index + 1),
    );
  }

  bool _hasEvent(DateTime day) {
    return widget.myEvents.any((event) =>
        event.date.year == day.year &&
        event.date.month == day.month &&
        event.date.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final monthName = DateFormat('MMMM y', 'es').format(_currentDate);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeMonth(-1),
              color: widget.primaryColor,
            ),
            Text(
              monthName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.primaryColor,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeMonth(1),
              color: widget.primaryColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
              .map((label) => Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.primaryColor,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...days.map((day) {
              final isSelected = _selectedDate != null &&
                  _selectedDate!.year == day.year &&
                  _selectedDate!.month == day.month &&
                  _selectedDate!.day == day.day;
              final hasEvent = _hasEvent(day);

              return GestureDetector(
                onTap: () => setState(() => _selectedDate = day),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? widget.primaryColor.withOpacity(0.2)
                        : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? widget.primaryColor
                          : hasEvent
                              ? widget.primaryColor.withOpacity(0.5)
                              : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? widget.primaryColor
                              : hasEvent
                                  ? widget.primaryColor.withOpacity(0.9)
                                  : Colors.black,
                        ),
                      ),
                      if (hasEvent)
                        Positioned(
                          bottom: 6,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: widget.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 20),
        if (_selectedDate != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eventos del ${DateFormat('d MMMM', 'es').format(_selectedDate!)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.primaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ...widget.myEvents
                  .where((event) =>
                      event.date.year == _selectedDate!.year &&
                      event.date.month == _selectedDate!.month &&
                      event.date.day == _selectedDate!.day)
                  .map((event) => Card(
                        child: ListTile(
                          title: Text(event.title),
                          subtitle: Text(DateFormat('HH:mm').format(event.date)),
                        ),
                      )),
            ],
          ),
      ],
    );
  }
}
