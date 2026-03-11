import 'package:flutter/material.dart';

/// A container that animates its shadow when the mouse hovers over it.
class AnimatedShadowBox extends StatefulWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const AnimatedShadowBox({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.borderRadius,
  });

  @override
  State<AnimatedShadowBox> createState() => _AnimatedShadowBoxState();
}

class _AnimatedShadowBoxState extends State<AnimatedShadowBox> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.25 : 0.1),
              blurRadius: _hovering ? 12 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }

  void _setHover(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}
