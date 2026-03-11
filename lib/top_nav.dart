import 'package:flutter/material.dart';
import 'logo.dart';

class TopNav extends StatelessWidget {
  /// Called when a navigation item is tapped. Receives the label (Home, Services, About, Contact).
  final void Function(String)? onItemSelected;

  const TopNav({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 700;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Logo(iconSize: 28),
            ],
          ),
          // center menu items when there is enough space
          if (!isNarrow)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => onItemSelected?.call('Home'),
                      child: const Text('Home')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: () => onItemSelected?.call('Services'),
                      child: const Text('Services')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: () => onItemSelected?.call('About'),
                      child: const Text('About')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: () => onItemSelected?.call('Contact'),
                      child: const Text('Contact')),
                ],
              ),
            ),
          isNarrow
              ? Row(children: [
                  PopupMenuButton<int>(
                    icon: const Icon(Icons.menu),
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(value: 0, child: Text('Home')),
                      const PopupMenuItem(value: 1, child: Text('Services')),
                      const PopupMenuItem(value: 2, child: Text('About')),
                      const PopupMenuItem(value: 3, child: Text('Contact')),
                    ],
                    onSelected: (v) {
                      switch (v) {
                        case 0:
                          onItemSelected?.call('Home');
                          break;
                        case 1:
                          onItemSelected?.call('Services');
                          break;
                        case 2:
                          onItemSelected?.call('About');
                          break;
                        case 3:
                          onItemSelected?.call('Contact');
                          break;
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: () => onItemSelected?.call('Contact'),
                      child: const Text('Contact Us'))
                ])
              : ElevatedButton(
                  onPressed: () => onItemSelected?.call('Contact'),
                  child: const Text('Contact Us'))
        ],
      ),
    );
  }
}
