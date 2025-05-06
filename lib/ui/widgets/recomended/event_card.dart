import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/pages/event_detail_page.dart';
import '../../controllers/event_controller.dart';

class EventCard extends StatelessWidget { 
  final Event event;
  final Color colorPrincipal;
  final User user;

  const EventCard({
    Key? key,
    required this.event,
    required this.colorPrincipal,
    required this.user,
  }) : super(key: key);

  Uint8List? _decodeBase64(String base64Str) {
    try {
      final regex = RegExp(r'data:image/[^;]+;base64,');
      final cleaned = base64Str.replaceAll(regex, '');
      return base64Decode(cleaned);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoEvento =
        EventUseCases.whenIs(event.initialDate, event.finalDate);
    final imageBytes = _decodeBase64(event.cardImageUrl);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EventDetailPage(
              event: event,
              colorPrincipal: colorPrincipal,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        height: 300,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorPrincipal, width: 5),
        ),
        child: Stack(
          children: [
            // Imagen de fondo
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: imageBytes != null
                    ? Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        colorBlendMode: BlendMode.darken,
                      )
                    : Container(
                        color: Colors.black12,
                        child: const Center(
                          child: Icon(Icons.broken_image,
                              size: 40, color: Colors.white),
                        ),
                      ),
              ),
            ),
            // Estado del evento
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  estadoEvento,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Info inferior y botón
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Texto del evento
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
                          Text(
                            event.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Botón de suscripción
                    Consumer<EventController>(
                      builder: (context, controller, _) {
                        final isSubscribed =
                            controller.checkSubscriptionStatus(event);
                        final isEventOver =
                            EventUseCases.isOver(event.finalDate);
                        final isEventAvailable =
                            EventUseCases.isAvailable(event, user);

                        Color buttonColor;
                        String buttonText;
                        bool isButtonEnabled;

                        if (isEventOver) {
                          buttonColor = Colors.grey;
                          buttonText = 'Finalizado';
                          isButtonEnabled = false;
                        } else if (!isEventAvailable && !isSubscribed) {
                          buttonColor = Colors.grey;
                          buttonText = 'No disponible';
                          isButtonEnabled = false;
                        } else {
                          buttonColor =
                              isSubscribed ? Colors.red : Colors.green;
                          buttonText =
                              isSubscribed ? 'Desuscribirse' : 'Suscribirse';
                          isButtonEnabled = true;
                        }

                        return SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () async => await controller
                                    .toggleSuscripcion(event, context)
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
            ),
          ],
        ),
      ),
    );
  }
}
