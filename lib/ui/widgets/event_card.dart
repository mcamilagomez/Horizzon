import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/app/event_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/domain/entities/event.dart';
import '../controllers/event_controller.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Color colorPrincipal;
  final User user;

  const EventCard({
    super.key,
    required this.event,
    required this.colorPrincipal,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EventController>(context, listen: false);
    final estadoEvento =
        EventUseCases.whenIs(event.initialDate, event.finalDate);
    var isSubscribed = EventUseCases.itsSubscribe(event, user.myEvents);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              eventId: event.id,
              titulo: event.name,
              slogan: event.description,
              fecha: EventUseCases.formatDate(event.initialDate),
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
            image: AssetImage(event.cardImageUrl),
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
                  estadoEvento,
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
                            onPressed: () {
                              final updatedEvents = isSubscribed
                                  ? EventUseCases.unsubscribe(
                                      event, user.myEvents)
                                  : EventUseCases.subscribe(
                                      event, user.myEvents);
                              isSubscribed = EventUseCases.itsSubscribe(
                                  event, updatedEvents);
                              user.myEvents = updatedEvents;

                              controller.toggleSuscripcion(event.id);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              backgroundColor:
                                  isSubscribed ? Colors.red : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              isSubscribed ? 'Desuscribirse' : 'Suscribirse',
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

  String _buildEventDetails(Event event) {
    return '''
${event.description}

Speakers: ${event.speakers.join(', ')}

Location: ${event.location}
Capacity: ${event.capacity} (${event.availableSeats} available)
Fecha: ${EventUseCases.formatDate(event.initialDate)} - ${EventUseCases.whenIs(event.initialDate, event.finalDate)}
''';
  }
}
