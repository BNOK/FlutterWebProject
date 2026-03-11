import 'package:flutter/material.dart';

/// Simple horizontal logo widget.  Paints a small circular icon followed by
/// the company name in a bright blue color from the palette.
class Logo extends StatelessWidget {
  /// diameter of the circular icon
  final double iconSize;

  const Logo({super.key, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1CC0F3);
    const iconColor = Color(0xFF942FA5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: const BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'VIONTECH',
          style: TextStyle(
            fontSize: iconSize * 0.8,
            fontWeight: FontWeight.bold,
            color: primary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
