import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/pages/event_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/domain/entities/event.dart';
import '../../controllers/event_controller.dart';

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
    final estadoEvento =
        EventUseCases.whenIs(event.initialDate, event.finalDate);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
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
                          buttonText =
                              isSubscribed ? 'Desuscribirse' : 'Suscribirse';
                          isButtonEnabled = false;
                        } else if (!isEventAvailable) {
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
                                ? () => controller.toggleSuscripcion(event)
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
