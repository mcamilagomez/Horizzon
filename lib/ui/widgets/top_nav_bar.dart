import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final String mainTitle;
  final String? subtitle; // Texto secundario opcional
  final Color baseColor;
  final double shineIntensity;
  final String imagePath;
  final double imageSize;

  const TopNavBar({
    super.key,
    required this.mainTitle,
    this.subtitle,
    this.baseColor = const Color(0xFF1976D2),
    this.shineIntensity = 0.15,
    this.imagePath = 'images/logo.png',
    this.imageSize = 70.0,
  });

  @override
  Widget build(BuildContext context) {
    final shineColor = Colors.white.withOpacity(shineIntensity);
    
    return Container(
      decoration: BoxDecoration(
        color: baseColor,
        border: Border(
          top: BorderSide(
            color: shineColor,
            width: 2.0,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              shineColor.withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0, // Reducido para el texto adicional
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mainTitle,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (subtitle != null) // Solo muestra si hay subtítulo
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
              ],
            ),
            Image.asset(
              imagePath,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}