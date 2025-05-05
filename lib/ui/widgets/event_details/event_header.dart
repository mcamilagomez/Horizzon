import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';
import 'package:horizzon/domain/use_case/use_case.dart';

class EventHeader extends StatelessWidget {
  final Event event;
  final User user;
  final Color color;

  const EventHeader({
    super.key,
    required this.event,
    required this.user,
    required this.color,
  });

  /// 🔁 Decodifica imagen base64 a bytes para usar en Image.memory
  Uint8List decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return Uint8List(0); // Imagen vacía si falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 📌 Textos del evento
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // 🖼 Imagen en base64
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                decodeBase64Image(event.coverImageUrl),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // 🔘 Botón de suscripción
            Consumer<EventController>(
              builder: (context, controller, _) {
                final isSubscribed = controller.checkSubscriptionStatus(event);
                final isEventOver = EventUseCases.isOver(event.finalDate);
                final isEventAvailable = EventUseCases.isAvailable(event, user);

                Color buttonColor;
                String buttonText;
                bool isButtonEnabled;

                if (isEventOver) {
                  buttonColor = Colors.grey;
                  buttonText = isSubscribed ? 'Desuscribirse' : 'Suscribirse';
                  isButtonEnabled = false;
                } else if (!isEventAvailable) {
                  buttonColor = Colors.grey;
                  buttonText = 'No disponible';
                  isButtonEnabled = false;
                } else {
                  buttonColor = isSubscribed ? Colors.red : Colors.green;
                  buttonText = isSubscribed ? 'Desuscribirse' : 'Suscribirse';
                  isButtonEnabled = true;
                }

                return SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () => controller.toggleSuscripcion(event)
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
