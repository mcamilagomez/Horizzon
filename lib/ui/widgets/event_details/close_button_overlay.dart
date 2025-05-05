import 'package:flutter/material.dart';

class CloseButtonOverlay extends StatelessWidget {
  final Color color;

  const CloseButtonOverlay({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      right: 20,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
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
    );
  }
}
