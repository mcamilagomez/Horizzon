import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/ui/app/event_detail_page.dart';
import 'package:horizzon/ui/controllers/event_controller.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Color primaryColor;
  final bool isDark;
  final User user;

  const EventCard({
    super.key,
    required this.event,
    required this.primaryColor,
    required this.isDark,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              event: event,
              colorPrincipal: primaryColor,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF3A3A3C) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(event.coverImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[300] : Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
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
                  height: 32,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () => controller.toggleSuscripcion(event)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
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