import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  final Color colorPrincipal;

  const EventDetailPage({
    super.key,
    required this.event,
    required this.colorPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Imagen principal del evento
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(event.cardImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Título del evento
                Text(
                  event.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorPrincipal,
                  ),
                ),
                const SizedBox(height: 8),

                // Descripción breve
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Detalles del evento en lista
                _buildDetailItem(
                  icon: Icons.calendar_today,
                  title: 'Fecha y hora',
                  value:
                      '${EventUseCases.formatDate(event.initialDate)} - ${_formatTimeRange(event.initialDate, event.finalDate)}',
                ),
                _buildDetailItem(
                  icon: Icons.location_on,
                  title: 'Ubicación',
                  value: event.location,
                ),
                _buildDetailItem(
                  icon: Icons.people,
                  title: 'Capacidad',
                  value:
                      '${event.capacity} personas (${event.availableSeats} disponibles)',
                ),
                _buildDetailItem(
                  icon: Icons.person,
                  title: 'Expositores',
                  value: event.speakers.join(', '),
                ),
                const SizedBox(height: 20),

                // Descripción extendida
                const Text(
                  'Acerca de este evento:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 30),

                // Botón de suscripción
                Consumer<EventController>(
                  builder: (context, controller, _) {
                    final isSubscribed =
                        controller.checkSubscriptionStatus(event);
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.toggleSuscripcion(event),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSubscribed ? Colors.red : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isSubscribed
                              ? 'DESUSCRIBIRSE'
                              : 'SUSCRIBIRSE A ESTE EVENTO',
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

          // Botón de cerrar
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

  // Widget para construir ítems de detalle
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorPrincipal, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Formatear rango de horas
  String _formatTimeRange(DateTime start, DateTime end) {
    final startTime =
        '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
    final endTime = '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
