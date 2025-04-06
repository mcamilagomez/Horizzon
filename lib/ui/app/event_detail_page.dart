import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';

class EventDetailPage extends StatelessWidget {
  final int eventId;
  final String titulo;
  final String slogan;
  final String fecha;
  final String detalles;
  final Color colorPrincipal;

  const EventDetailPage({
    super.key,
    required this.eventId,
    required this.titulo,
    required this.slogan,
    required this.fecha,
    required this.detalles,
    required this.colorPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EventController>(context, listen: false);

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Container(
                  decoration: BoxDecoration(
                    color: colorPrincipal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorPrincipal, width: 2),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorPrincipal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        slogan,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Fecha: $fecha',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Detalles del evento:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(detalles, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      Consumer<EventController>(
                        builder: (context, controller, _) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  () => controller.toggleSuscripcion(eventId),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.isSuscrito(eventId)
                                        ? Colors.red
                                        : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                controller.isSuscrito(eventId)
                                    ? 'DESUSCRIBIRSE'
                                    : 'SUSCRIBIRSE',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
