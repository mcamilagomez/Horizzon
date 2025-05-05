import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';

class EventReviewsList extends StatelessWidget {
  final List<FeedbackbyUser> feedbacks;
  final Color color;

  const EventReviewsList({
    super.key,
    required this.feedbacks,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (feedbacks.isEmpty) {
      return const Text(
        'Aún no hay reviews para este evento',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          feedbacks.map((feedback) => _buildReviewItem(feedback)).toList(),
    );
  }

  Widget _buildReviewItem(FeedbackbyUser feedback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Usuario y avatar
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(Icons.person, color: color),
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
          // Estrellas
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
          // Comentario
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
}
