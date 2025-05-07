// test/widgets/month_selector_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:horizzon/ui/widgets/agenda_content/month_selector.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Mock translation function
class TranslationsMock extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'january': 'January',
          'february': 'February',
          // Add other translations as needed
        },
        'es': {
          'january': 'Enero',
          'february': 'Febrero',
          // Add other translations as needed
        },
      };
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Initialize date formatting and GetX
    initializeDateFormatting();
    Get.testMode = true;
    Get.put(TranslationsMock());
    Get.locale = const Locale('en', 'US');
  });

  // Helper widget to simplify test setup
  Widget testWidget({
    required DateTime currentDate,
    required Function(int) onChangeMonth,
  }) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 18.0),
      ),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        backgroundColor: Colors.blue, // So onPrimary color is visible
        body: MonthSelector(
          currentDate: currentDate,
          onChangeMonth: onChangeMonth,
          themeData: theme,
        ),
      ),
    );
  }

  testWidgets('Displays the current month and year correctly', (WidgetTester tester) async {
    final testDate = DateTime(2023, 7, 15); // July 15, 2023
    int changeMonthCalled = 0;

    await tester.pumpWidget(
      testWidget(
        currentDate: testDate,
        onChangeMonth: (change) {
          changeMonthCalled += change;
        },
      ),
    );

    // Format the expected date string the same way as the widget does
    final expectedMonthYear = DateFormat('MMMM y', 'en').format(testDate);
    
    // Verify the month and year are displayed correctly
    expect(find.text(expectedMonthYear), findsOneWidget);
  });

  testWidgets('Calls onChangeMonth with -1 when left arrow is pressed', (WidgetTester tester) async {
    final testDate = DateTime(2023, 7, 15);
    int monthChange = 0;

    await tester.pumpWidget(
      testWidget(
        currentDate: testDate,
        onChangeMonth: (change) {
          monthChange = change;
        },
      ),
    );

    // Find and tap the left arrow
    final leftArrow = find.byIcon(Icons.chevron_left);
    expect(leftArrow, findsOneWidget);
    await tester.tap(leftArrow);
    await tester.pump();

    // Verify the callback was called with -1
    expect(monthChange, -1);
  });

  testWidgets('Calls onChangeMonth with 1 when right arrow is pressed', (WidgetTester tester) async {
    final testDate = DateTime(2023, 7, 15);
    int monthChange = 0;

    await tester.pumpWidget(
      testWidget(
        currentDate: testDate,
        onChangeMonth: (change) {
          monthChange = change;
        },
      ),
    );

    // Find and tap the right arrow
    final rightArrow = find.byIcon(Icons.chevron_right);
    expect(rightArrow, findsOneWidget);
    await tester.tap(rightArrow);
    await tester.pump();

    // Verify the callback was called with 1
    expect(monthChange, 1);
  });

  testWidgets('Uses provided theme data for styling', (WidgetTester tester) async {
    final testDate = DateTime(2023, 7, 15);
    
    await tester.pumpWidget(
      testWidget(
        currentDate: testDate,
        onChangeMonth: (_) {},
      ),
    );

    // Find the month text widget
    final monthTextFinder = find.text(DateFormat('MMMM y', 'en').format(testDate));
    final Text monthText = tester.widget(monthTextFinder);
    
    // Verify the text style uses theme data
    expect(monthText.style?.fontWeight, FontWeight.bold);
    expect(monthText.style?.color, Colors.white); // from onPrimary in our test theme
  });

  testWidgets('Displays localized month name based on current locale', (WidgetTester tester) async {
    final testDate = DateTime(2023, 7, 15); // July 15, 2023
    
    // Change locale to Spanish
    Get.locale = const Locale('es', 'ES');
    
    await tester.pumpWidget(
      testWidget(
        currentDate: testDate,
        onChangeMonth: (_) {},
      ),
    );

    // Format the expected date string in Spanish
    final expectedMonthYear = DateFormat('MMMM y', 'es').format(testDate);
    
    // Verify the month name is displayed in Spanish
    expect(find.text(expectedMonthYear), findsOneWidget);
  });
}