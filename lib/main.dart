// main.dart
import 'package:flutter/material.dart';

import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/ui/my_app.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController()),
      ],
      child: const MyApp(),
    ),
  );
}
