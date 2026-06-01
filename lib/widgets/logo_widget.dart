import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool darkBackground;

  const LogoWidget({super.key, this.size = 80, this.darkBackground = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.2),
        child: Image.asset(
          'assets/image/logo.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              child: Icon(Icons.image_not_supported, size: size * 0.5),
            );
          },
        ),
      ),
    );
  }
}
