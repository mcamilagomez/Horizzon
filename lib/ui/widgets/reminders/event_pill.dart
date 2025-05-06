import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/pages/event_detail_page.dart';
import 'dart:typed_data';

class EventPill extends StatelessWidget {
  final Event event;
  final Color colorPrincipal;
  final User user;

  const EventPill({
    super.key,
    required this.event,
    required this.colorPrincipal,
    required this.user,
  });

  /// Decodifica base64 con cabecera (ej: data:image/png;base64,...)
  Uint8List? _decodeBase64Image(String base64Str) {
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
    final base64 = event.cardImageUrl;
    final decodedBytes = _decodeBase64Image(base64);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              event: event,
              colorPrincipal: colorPrincipal,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              if (decodedBytes != null)
                Image.memory(
                  decodedBytes,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                )
              else
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black12,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),

              // Fecha
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorPrincipal.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    EventUseCases.whenIs(event.initialDate, event.finalDate),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Nombre del evento
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  event.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
