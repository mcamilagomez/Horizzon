// event_detail_page.dart
import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/ui/widgets/event_details/event_details_section.dart';
import 'package:horizzon/ui/widgets/event_details/event_header.dart';
import 'package:horizzon/ui/widgets/event_details/feedback_form.dart';
import 'package:horizzon/ui/widgets/event_details/reviews_list.dart';
import 'package:horizzon/ui/widgets/event_details/close_button_overlay.dart';
import 'package:horizzon/utils/img_utils.dart';
import 'package:provider/provider.dart'; // ← asegúrate de importar esto
import 'package:horizzon/domain/repositories/master_repository.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  final Color colorPrincipal;
  final User user;

  const EventDetailPage({
    super.key,
    required this.event,
    required this.colorPrincipal,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final imageBytes = decodeBase64Image(event.cardImageUrl);

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
                  background: imageBytes.isNotEmpty
                      ? Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                            child:
                                Icon(Icons.broken_image, color: Colors.white),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.broken_image, color: Colors.white),
                        ),
                ),
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
              ),
              EventHeader(event: event, user: user, color: colorPrincipal),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventDetailsSection(event: event, color: colorPrincipal),
                      const SizedBox(height: 30),
                      FeedbackForm(
                        event: event,
                        user: user,
                        color: colorPrincipal,
                        masterRepo: Provider.of<MasterRepository>(context,
                            listen: false),
                      ),
                      const SizedBox(height: 24),
                      EventReviewsList(
                          feedbacks: event.feedbacks, color: colorPrincipal),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CloseButtonOverlay(color: colorPrincipal),
        ],
      ),
    );
  }
}
