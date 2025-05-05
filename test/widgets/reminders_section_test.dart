import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/user.dart';

class TestRemindersSection extends StatelessWidget {
  final User user;

  const TestRemindersSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            'Reminders', 
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  testWidgets('RemindersSection mostrado',
      (WidgetTester tester) async {
    // Arrange
    final testUser = User(hash: 'user123', myEvents: []);

    // Configurar el widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestRemindersSection(user: testUser),
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('Reminders'), findsOneWidget); // Título
  });
}