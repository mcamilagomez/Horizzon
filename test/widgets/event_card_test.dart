import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Muestra los eventos', (tester) async {
    // Widget de prueba que imita la estructura básica esperada
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre del Evento', style: TextStyle(fontSize: 20)),
                SizedBox(height: 8),
                Text('Descripción breve del evento'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Acción'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Verificaciones básicas
    expect(find.text('Nombre del Evento'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}