import 'package:flutter/material.dart';
import 'animated_box.dart';

/// Reusable box that displays an icon, a title and arbitrary content.
/// It applies the same animated shadow effect as the rest of the site.
class SectionBox extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Widget child;
  final Color backgroundColor;

  const SectionBox({
    super.key,
    this.icon,
    this.title,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedShadowBox(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null && (title?.isNotEmpty ?? false)) ...[
              Row(
                children: [
                  Icon(icon, color: Colors.indigo, size: 32),
                  const SizedBox(width: 8),
                  Text(title!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
