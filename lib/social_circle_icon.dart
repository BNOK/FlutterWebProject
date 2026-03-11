import 'package:flutter/material.dart';

/// Circular icon button with hover animation, used for social links.
class SocialCircleIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const SocialCircleIcon({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  State<SocialCircleIcon> createState() => _SocialCircleIconState();
}

class _SocialCircleIconState extends State<SocialCircleIcon> {
  bool _hovering = false;

  void _setHover(bool value) {
    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = _hovering ? 56.0 : 48.0;
    final color = _hovering ? Colors.blue.shade100 : Colors.blue.shade50;

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, color: Colors.blue.shade700),
        ),
      ),
    );
  }
}
