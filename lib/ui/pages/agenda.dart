import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  final ScrollController _daysScrollController = ScrollController();
  final Color _primaryColor = const Color.fromRGBO(18, 37, 98, 1);

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
        'weekday': DateFormat('E').format(date),
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

  @override
  Widget build(BuildContext context) {
    final currentMonthYear = DateFormat('MMMM y').format(_currentDate);
    final daysInMonth = _getDaysInMonth();

    return Scaffold(
      backgroundColor: _primaryColor,
      body: Column(
        children: [
          // TopNavBar fijo en la parte superior
          const TopNavBar(
            mainTitle: "Agenda",
            subtitle: "Horizzon",
            baseColor: Color.fromRGBO(18, 37, 98, 1),
            shineIntensity: 0.6,
          ),
          
          // Contenido desplazable
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
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

                        const SizedBox(height: 20),

                        // Días del mes con scroll horizontal
                        SizedBox(
                          height: 90,
                          child: Stack(
                            children: [
                              // Flecha izquierda
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
                                  color: _primaryColor,
                                ),
                              ),

                              // Lista de días
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
                                    final isSelected = _selectedDate != null && 
                                                    _selectedDate!.year == date.year &&
                                                    _selectedDate!.month == date.month &&
                                                    _selectedDate!.day == date.day;
                                    final isWeekend = day['weekday'] == 'Sat' || day['weekday'] == 'Sun';
                                    
                                    return GestureDetector(
                                      onTap: () => _onDaySelected(date),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? _primaryColor.withOpacity(0.2)
                                                : isToday
                                                    ? _primaryColor.withOpacity(0.1)
                                                    : isWeekend
                                                        ? Colors.grey[100]
                                                        : Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: isSelected
                                                  ? _primaryColor
                                                  : isToday
                                                      ? _primaryColor
                                                      : Colors.grey[200]!,
                                              width: isSelected ? 2 : (isToday ? 2 : 1),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                day['day'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: isSelected
                                                      ? _primaryColor
                                                      : isToday
                                                          ? _primaryColor
                                                          : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                day['weekday'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected
                                                      ? _primaryColor
                                                      : isToday
                                                          ? _primaryColor
                                                          : Colors.grey[600],
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

                              // Flecha derecha
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
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Fecha seleccionada
                        if (_selectedDate != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Center(
                              child: Text(
                                'Seleccionado: ${DateFormat('EEEE, d MMMM y').format(_selectedDate!)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

 
                      ],
                    ),
                  ),
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