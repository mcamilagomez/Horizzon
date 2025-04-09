import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';

class EventDetailPage extends StatefulWidget {
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
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _selectedStars = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitFeedback(BuildContext context) async {
    if (_selectedStars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('event.ratingRequired'.tr)),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      EventUseCases.addFeedback(
        _commentController.text,
        widget.event,
        _selectedStars,
        'User${widget.user.hash}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('event.thanksReview'.tr)),
      );

      _commentController.clear();
      setState(() {
        _selectedStars = 0;
        _isSubmitting = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      setState(() => _isSubmitting = false);
    }
  }

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
                    widget.event.cardImageUrl,
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
                    color: widget.colorPrincipal,
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
                              widget.event.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.event.description,
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
                          final isSubscribed = controller.checkSubscriptionStatus(widget.event);
                          final isEventOver = EventUseCases.isOver(widget.event.finalDate);
                          final isEventAvailable = EventUseCases.isAvailable(widget.event, widget.user);

                          Color buttonColor;
                          String buttonText;
                          bool isButtonEnabled;

                          if (isEventOver) {
                            buttonColor = Colors.grey;
                            buttonText = isSubscribed ? 'event.unsubscribe'.tr : 'event.subscribe'.tr;
                            isButtonEnabled = false;
                          } else if (!isEventAvailable) {
                            buttonColor = Colors.grey;
                            buttonText = 'event.notAvailable'.tr;
                            isButtonEnabled = false;
                          } else {
                            buttonColor = isSubscribed ? Colors.red : Colors.green;
                            buttonText = isSubscribed ? 'event.unsubscribe'.tr : 'event.subscribe'.tr;
                            isButtonEnabled = true;
                          }

                          return SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () => controller.toggleSuscripcion(widget.event)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.longDescription,
                        style: const TextStyle(fontSize: 18, height: 1.6),
                      ),
                      const SizedBox(height: 30),
                      _buildInlineDetail('event.line'.tr, widget.event.eventTrackName),
                      const SizedBox(height: 16),
                      _buildInlineDetail('event.place'.tr, widget.event.location),
                      const SizedBox(height: 16),
                      _buildInlineDetail('event.date'.tr, EventUseCases.formatDate(widget.event.initialDate)),
                      const SizedBox(height: 16),
                      _buildInlineDetail('event.time'.tr, _formatTimeRange(widget.event.initialDate, widget.event.finalDate)),
                      const SizedBox(height: 16),
                      _buildInlineDetail('event.capacity'.tr, '${widget.event.capacity} personas (${widget.event.availableSeats} disponibles)'),
                      const SizedBox(height: 16),
                      if (widget.event.speakers.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'event.speakers'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.colorPrincipal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...widget.event.speakers.map((speaker) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $speaker', style: const TextStyle(fontSize: 16)),
                            )),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        'event.reviews'.tr,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: widget.colorPrincipal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return IconButton(
                                  icon: Icon(
                                    index < _selectedStars ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedStars = index + 1;
                                    });
                                  },
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                labelText: 'event.commentOptional'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                isDense: true,
                              ),
                              maxLines: 2,
                              minLines: 1,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isSubmitting ? null : () => _submitFeedback(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.colorPrincipal,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: _isSubmitting
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        'event.sendReview'.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      if (widget.event.feedbacks.isEmpty)
                        Text(
                          'event.noReviews'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )
                      else
                        ...widget.event.feedbacks.map((feedback) => _buildReviewItem(feedback)).toList(),
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
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: widget.colorPrincipal,
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

  Widget _buildReviewItem(FeedbackbyUser feedback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: widget.colorPrincipal.withOpacity(0.2),
                child: Icon(Icons.person, color: widget.colorPrincipal),
              ),
              const SizedBox(width: 12),
              Text(
                feedback.userId.length > 8 ? '${feedback.userId.substring(0, 8)}...' : feedback.userId,
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
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
        ],
      ),
    );
  }

  Widget _buildInlineDetail(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: widget.colorPrincipal),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    final startTime = '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
    final endTime = '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
