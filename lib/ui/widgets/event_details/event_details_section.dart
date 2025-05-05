import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/use_case/use_case.dart';

class EventDetailsSection extends StatelessWidget {
  final Event event;
  final Color color;

  const EventDetailsSection({
    super.key,
    required this.event,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _buildInlineDetail('Línea de evento', event.eventTrackName),
        const SizedBox(height: 16),
        _buildInlineDetail('Lugar', event.location),
        const SizedBox(height: 16),
        _buildInlineDetail(
          'Fecha',
          EventUseCases.formatDate(event.initialDate),
        ),
        const SizedBox(height: 16),
        _buildInlineDetail(
          'Horario',
          _formatTimeRange(event.initialDate, event.finalDate),
        ),
        const SizedBox(height: 16),
        _buildInlineDetail(
          'Capacidad',
          '${event.capacity} personas '
              '(${event.availableSeats} disponibles)',
        ),
        const SizedBox(height: 16),
        if (event.speakers.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Expositores:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...event.speakers.map(
            (speaker) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $speaker',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ],
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
              color: color,
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
