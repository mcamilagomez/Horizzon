import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/ui/widgets/event_details/close_button_overlay.dart';

// Widget simplificado para pruebas
class TestEventDetailPage extends StatelessWidget {
  final Color colorPrincipal;

  const TestEventDetailPage({
    super.key,
    required this.colorPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CloseButtonOverlay(color: colorPrincipal),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('EventDetailPage renderizado',
      (WidgetTester tester) async {
    // Arrange
    final testColor = Colors.blue;

    // Configurar el widget
    await tester.pumpWidget(
      MaterialApp(
        home: TestEventDetailPage(
          colorPrincipal: testColor,
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.byType(CloseButtonOverlay), findsOneWidget); // Botón de cerrar
  });
}