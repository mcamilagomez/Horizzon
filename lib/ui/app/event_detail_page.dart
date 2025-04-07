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
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: false,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    event.cardImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              SliverToBoxAdapter(
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
                          return SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () =>
                                  controller.toggleSuscripcion(event),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.longDescription,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildInlineDetail(
                          'Linea de evento', event.eventTrackName),
                      const SizedBox(height: 16),
                      _buildInlineDetail('Lugar', event.location),
                      const SizedBox(height: 16),
                      _buildInlineDetail(
                          'Fecha', EventUseCases.formatDate(event.initialDate)),
                      const SizedBox(height: 16),
                      _buildInlineDetail('Horario',
                          _formatTimeRange(event.initialDate, event.finalDate)),
                      const SizedBox(height: 16),
                      _buildInlineDetail(
                          'Capacidad',
                          '${event.capacity} personas '
                              '(${event.availableSeats} disponibles)'),
                      const SizedBox(height: 16),
                      if (event.speakers.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Expositores:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorPrincipal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...event.speakers.map((speaker) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                '• $speaker',
                                style: const TextStyle(fontSize: 16),
                              ),
                            )),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colorPrincipal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (event.feedbacks.isEmpty)
                        const Text(
                          'Aún no hay reviews para este evento',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )
                      else
                        ...event.feedbacks
                            .map((feedback) => _buildReviewItem(feedback))
                            .toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: GestureDetector(
              onTap: () => _closeWithTransition(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _closeWithTransition(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Método para navegar a esta página con la transición personalizada
  static PageRouteBuilder<dynamic> buildRoute(Event event, Color color) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EventDetailPage(
        event: event,
        colorPrincipal: color,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildReviewItem(FeedbackbyUser feedback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: colorPrincipal.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: colorPrincipal,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                feedback.userId.length > 8
                    ? '${feedback.userId.substring(0, 8)}...'
                    : feedback.userId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < feedback.stars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 8),
          if (feedback.comment.isNotEmpty)
            Text(
              feedback.comment,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInlineDetail(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorPrincipal,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    final startTime =
        '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
    final endTime = '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
