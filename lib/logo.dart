import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double iconSize;

  const Logo({super.key, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1CC0F3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
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
