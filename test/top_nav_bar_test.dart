import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/ui/widgets/top_nav_bar.dart'; // Ajusta la ruta según tu estructura

void main() {
  // Método auxiliar para crear el widget bajo prueba
  Widget createTopNavBar({
    String mainTitle = 'Test Title',
    String? subtitle,
    Color baseColor = const Color.fromARGB(255, 63, 181, 255),
    double shineIntensity = 0.15,
    String imagePath = 'assets/images/logo.png',
    double imageSize = 70.0,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: TopNavBar(
          mainTitle: mainTitle,
          subtitle: subtitle,
          baseColor: baseColor,
          shineIntensity: shineIntensity,
          imagePath: imagePath,
          imageSize: imageSize,
        ),
      ),
    );
  }

  group('TopNavBar Widget Tests', () {
    testWidgets('Debe mostrar el título principal', (WidgetTester tester) async {
      await tester.pumpWidget(createTopNavBar(mainTitle: 'Test Title'));
      await tester.pump();

      expect(find.text('Test Title'), findsOneWidget);
      final titleText = tester.widget<Text>(find.text('Test Title'));
      expect(titleText.style?.fontSize, 23);
      expect(titleText.style?.fontWeight, FontWeight.bold);
      expect(titleText.style?.color, Colors.white);
    });

    testWidgets('Debe mostrar el subtítulo cuando se proporciona', (WidgetTester tester) async {
      await tester.pumpWidget(createTopNavBar(
        mainTitle: 'Test Title',
        subtitle: 'Test Subtitle',
      ));
      await tester.pump();

      expect(find.text('Test Subtitle'), findsOneWidget);
      final subtitleText = tester.widget<Text>(find.text('Test Subtitle'));
      expect(subtitleText.style?.fontSize, 11);
      expect(subtitleText.style?.fontStyle, FontStyle.italic);
      expect(subtitleText.style?.color, Colors.white.withOpacity(0.9));
    });

    testWidgets('No debe mostrar el subtítulo cuando no se proporciona', (WidgetTester tester) async {
      await tester.pumpWidget(createTopNavBar(mainTitle: 'Test Title'));
      await tester.pump();

      expect(find.text('Test Subtitle'), findsNothing);
    });

    testWidgets('Debe usar el color base correcto', (WidgetTester tester) async {
      const customColor = Colors.red;
      await tester.pumpWidget(createTopNavBar(
        mainTitle: 'Test Title',
        baseColor: customColor,
      ));
      await tester.pump();

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customColor);
    });

    testWidgets('Debe mostrar la imagen con el tamaño correcto', (WidgetTester tester) async {
      const customSize = 50.0;
      await tester.pumpWidget(createTopNavBar(
        mainTitle: 'Test Title',
        imageSize: customSize,
      ));
      await tester.pump();

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, customSize);
      expect(image.height, customSize);
      expect(image.fit, BoxFit.contain);
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, 'assets/images/logo.png');
    });

    testWidgets('Debe aplicar el gradiente de brillo', (WidgetTester tester) async {
      const shineIntensity = 0.3;
      await tester.pumpWidget(createTopNavBar(
        mainTitle: 'Test Title',
        shineIntensity: shineIntensity,
      ));
      await tester.pump();

      final innerContainer = tester.widget<Container>(find.byType(Container).at(1));
      expect(innerContainer.decoration, isA<BoxDecoration>());
      final decoration = innerContainer.decoration as BoxDecoration;
      expect(decoration.gradient, isA<LinearGradient>());
      final gradient = decoration.gradient as LinearGradient;
      expect(gradient.begin, Alignment.topCenter);
      expect(gradient.end, Alignment.center);
      expect(gradient.colors[0], Colors.white.withOpacity(0.2));
      expect(gradient.colors[1], Colors.transparent);
      expect(gradient.stops, [0.0, 0.5]);
    });

    testWidgets('Debe usar el color de brillo en el borde superior', (WidgetTester tester) async {
      const shineIntensity = 0.5;
      await tester.pumpWidget(createTopNavBar(
        mainTitle: 'Test Title',
        shineIntensity: shineIntensity,
      ));
      await tester.pump();

      final outerContainer = tester.widget<Container>(find.byType(Container).first);
      expect(outerContainer.decoration, isA<BoxDecoration>());
      final decoration = outerContainer.decoration as BoxDecoration;
      expect(decoration.border, isA<Border>());
      final border = decoration.border as Border;
      expect(border.top.color, Colors.white.withOpacity(shineIntensity));
      expect(border.top.width, 2.0);
    });
  });
}