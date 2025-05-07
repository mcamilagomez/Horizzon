import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Inicializar la infraestructura de pruebas de integración
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de integración mínima - verificar que funciona', 
      (WidgetTester tester) async {
    
    // Lanzar una aplicación extremadamente simple
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Horizzon App Test'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Test de integración'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Botón de prueba'),
                ),
              ],
            ),
          ),
        ),
      )
    );
    
    // Esperar a que se completen todas las animaciones
    await tester.pumpAndSettle();
    
    // Verificar que los elementos básicos estén presentes
    expect(find.text('Horizzon App Test'), findsOneWidget);
    expect(find.text('Test de integración'), findsOneWidget);
    expect(find.text('Botón de prueba'), findsOneWidget);
    
    // Probar una interacción básica
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
  });
}