import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade800,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('VIONTECH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('© 2026 VIONTECH', style: TextStyle(color: Colors.white70)),
            ],
          ),
          Row(children: const [Icon(Icons.facebook, color: Colors.white), SizedBox(width: 12), Icon(Icons.share_outlined, color: Colors.white)]),
        ],
      ),
    );
  }
}
