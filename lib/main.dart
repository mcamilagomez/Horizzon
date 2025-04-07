// main.dart
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/ui/my_app.dart';

void main() {
  final user = User(hash: "123456", myEvents: []);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController(user: user)),
      ],
      child: const MyApp(),
    ),
  );
}
