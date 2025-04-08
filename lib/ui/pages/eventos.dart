import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/entities/user.dart'; // <-- importación del User
import '../widgets/bottom_nav_bar.dart';
import '../widgets/top_nav_bar.dart';
import '/ui/app/event_detail_page.dart';

class EventosPage extends StatefulWidget {
  final User user;

  const EventosPage({super.key, required this.user});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  final Set<int> _subscribedEvents = {};
  final Map<int, bool> _expandedTracks = {};
  late final Master master;
  final primaryColor = const Color.fromRGBO(18, 37, 98, 1);

  @override
  void initState() {
    super.initState();
    master = Master.createWithSampleData();
    for (var track in master.eventTracks) {
      _expandedTracks[track.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const TopNavBar(
            mainTitle: "Líneas de Eventos",
            subtitle: "Horizzon",
            baseColor: Color.fromRGBO(18, 37, 98, 1),
            shineIntensity: 0.6,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Todos los eventos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: master.eventTracks.length,
                        itemBuilder: (context, trackIndex) {
                          final track = master.eventTracks[trackIndex];
                          final isExpanded = _expandedTracks[track.id] ?? false;
                          final eventsToShow = isExpanded
                              ? track.events
                              : track.events.take(2).toList();

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildTrackHeader(track),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    children: [
                                      ...eventsToShow.map((event) =>
                                          _buildCompactEventCard(event, context)).toList(),
                                      if (track.events.length > 2)
                                        _buildExpandButton(track.id, isExpanded),
                                    ],
                                  ),
                                ),
                                if (trackIndex != master.eventTracks.length - 1)
                                  const Divider(height: 1, thickness: 1),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildTrackHeader(EventTrack track) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(track.coverImageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Container(
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
    );
  }

  Widget _buildCompactEventCard(Event event, BuildContext context) {
    final isSubscribed = _subscribedEvents.contains(event.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              event: event,
              colorPrincipal: primaryColor,
              user: widget.user, // ✅ Pasamos el objeto User aquí
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 32,
              width: 100,
              child: ElevatedButton(
                onPressed: () => _toggleSubscription(event.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSubscribed ? Colors.red : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  isSubscribed ? "Suscrito" : "Suscribirse",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandButton(int trackId, bool isExpanded) {
    return TextButton(
      onPressed: () => _toggleTrackExpansion(trackId),
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
                ? "Mostrar menos"
                : "Mostrar más (${master.eventTracks.firstWhere((t) => t.id == trackId).events.length - 2})",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _toggleSubscription(int eventId) {
    setState(() {
      if (_subscribedEvents.contains(eventId)) {
        _subscribedEvents.remove(eventId);
      } else {
        _subscribedEvents.add(eventId);
      }
    });
  }

  void _toggleTrackExpansion(int trackId) {
    setState(() {
      _expandedTracks[trackId] = !(_expandedTracks[trackId] ?? false);
    });
  }
}
