import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/eventos_content/event_card_eventos.dart';

class EventTrackCard extends StatelessWidget {
  final EventTrack track;
  final bool isExpanded;
  final Color primaryColor;
  final bool isDark;
  final User user;
  final Function(int) onToggleExpand;

  const EventTrackCard({
    super.key,
    required this.track,
    required this.isExpanded,
    required this.primaryColor,
    required this.isDark,
    required this.user,
    required this.onToggleExpand,
  });

  /// Helper para decodificar base64 con encabezado
  Uint8List? _decodeBase64(String base64Str) {
    try {
      final regex = RegExp(r'data:image/[^;]+;base64,');
      final cleaned = base64Str.replaceAll(regex, '');
      return base64Decode(cleaned);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.grey[200]!;
    final eventsToShow =
        isExpanded ? track.events : track.events.take(2).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTrackHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ...eventsToShow.map((event) => EventCard(
                      event: event,
                      primaryColor: primaryColor,
                      isDark: isDark,
                      user: user,
                    )),
                if (track.events.length > 2) _buildExpandButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackHeader() {
    final imageBytes = _decodeBase64(track.coverImageUrl);

    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageBytes != null)
            Image.memory(
              imageBytes,
              fit: BoxFit.cover,
            )
          else
            Container(
              color: Colors.black12,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  track.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandButton() {
    return TextButton(
      onPressed: () => onToggleExpand(track.id),
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue[600],
        padding: EdgeInsets.zero,
      ),
      child: Column(
        children: [
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 24,
          ),
          Text(
            isExpanded
                ? "showLess".tr
                : "${"showMore".tr} (${track.events.length - 2} ${"eventsLeft".tr})",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
