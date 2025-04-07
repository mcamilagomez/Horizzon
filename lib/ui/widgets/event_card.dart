// event_card.dart
import 'package:flutter/material.dart';
import 'package:horizzon/ui/app/event_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/domain/entities/event.dart';
import '../controllers/event_controller.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Color colorPrincipal;

  const EventCard({
    super.key,
    required this.event,
    required this.colorPrincipal,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EventController>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              eventId: event.id,
              titulo: event.name,
              slogan: event.description,
              fecha: _formatDate(event.initialDate),
              detalles: _buildEventDetails(event),
              colorPrincipal: colorPrincipal,
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
          image: DecorationImage(
            image: AssetImage(
                event.cardImageUrl), // Cambiado de AssetImage a NetworkImage
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromRGBO(0, 0, 0, 0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  _formatDate(event.initialDate),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Consumer<EventController>(
                      builder: (context, controller, _) {
                        return SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () =>
                                controller.toggleSuscripcion(event.id),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              backgroundColor: controller.isSuscrito(event.id)
                                  ? Colors.red
                                  : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              controller.isSuscrito(event.id)
                                  ? 'Desuscribirse'
                                  : 'Suscribirse',
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _buildEventDetails(Event event) {
    return '''
${event.description}

Speakers: ${event.speakers.join(', ')}

Location: ${event.location}
Capacity: ${event.capacity} (${event.availableSeats} available)
''';
  }
}
