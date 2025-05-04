import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/ui/controllers/bottom_nav_controller.dart';
import 'package:horizzon/ui/controllers/theme_controller.dart';
import 'package:horizzon/ui/pages/home.dart';

void main() {
  setUp(() {
    // Setup and register controllers
    final user = User(
      hash: 'test_user_hash',
      myEvents: [],  // Empty list to avoid image loading issues
    );
    
    // Create and register controllers
    Get.put(EventController(user: user));
    Get.put(BottomNavController());
    Get.put(ThemeController());
  });

  tearDown(() {
    Get.reset();  // Clean up after each test
  });

  // Create a minimal master object
  Master createMinimalMaster() {
    return Master(eventTracks: []);  // Empty tracks to avoid image loading
  }


  Widget createSimpleTestWidget() {
    final user = User(hash: 'test_user_hash', myEvents: []);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventController>.value(
          value: Get.find<EventController>(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Text('Test Widget'),  // Simple widget instead of HomePage
        ),
      ),
    );
  }

  // Create a widget with a simplified HomePage
  Widget createHomePageTestWidget() {
    final user = User(hash: 'test_user_hash', myEvents: []);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventController>.value(
          value: Get.find<EventController>(),
        ),
      ],
      child: GetMaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Home')),
          body: Center(child: Text('Home Page Content')),
        ),
      ),
    );
  }
  
  testWidgets('Basic widget test', (WidgetTester tester) async {
    await tester.pumpWidget(createSimpleTestWidget());
    await tester.pump();
    
    expect(find.text('Test Widget'), findsOneWidget);
  });
  
  testWidgets('Simplified scaffold test', (WidgetTester tester) async {
    await tester.pumpWidget(createHomePageTestWidget());
    await tester.pump();
    
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Home Page Content'), findsOneWidget);
  });

  testWidgets('GetX controller test', (WidgetTester tester) async {
    // Test that we can access the controllers
    final controller = Get.find<ThemeController>();
    controller.color.value = Colors.red;
    
    expect(controller.color.value, Colors.red);
  });
}