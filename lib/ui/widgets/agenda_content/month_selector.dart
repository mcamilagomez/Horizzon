// lib/ui/widgets/agenda/month_selector.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MonthSelector extends StatelessWidget {
  final DateTime currentDate;
  final Function(int) onChangeMonth;
  final ThemeData themeData;

  const MonthSelector({
    Key? key,
    required this.currentDate,
    required this.onChangeMonth,
    required this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentMonthYear = 
        DateFormat('MMMM y', Get.locale?.languageCode ?? 'es')
            .format(currentDate);
            
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => onChangeMonth(-1),
              color: themeData.colorScheme.onPrimary,
            ),
            Text(
              currentMonthYear,
              style: themeData.textTheme.titleLarge?.copyWith(
                color: themeData.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => onChangeMonth(1),
              color: themeData.colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}