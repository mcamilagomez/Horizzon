import 'package:flutter/material.dart';
import 'package:horizzon/ui/app/event_detail_page.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';

class EventCard extends StatelessWidget {
  final int eventId;
  final String titulo;
  final String slogan;
  final String fecha;
  final String imagenFondo;
  final String detalles;
  final Color colorPrincipal;

  const EventCard({
    super.key,
    required this.eventId,
    required this.titulo,
    required this.slogan,
    required this.fecha,
    required this.imagenFondo,
    required this.detalles,
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
              eventId: eventId,
              titulo: titulo,
              slogan: slogan,
              fecha: fecha,
              detalles: detalles,
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
            image: AssetImage(imagenFondo),
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
                  fecha,
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
                            titulo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            slogan,
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
                                controller.toggleSuscripcion(eventId),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              backgroundColor: controller.isSuscrito(eventId)
                                  ? Colors.red
                                  : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              controller.isSuscrito(eventId)
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
}
