import 'package:flutter/material.dart';
import 'logo.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 800;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isNarrow ? 20 : 64, vertical: 48),
      child: Column(
        children: [
          const Logo(iconSize: 32),
          const SizedBox(height: 24),
          Flex(
            direction: isNarrow ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isNarrow ? 0 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Premium Mobility Solutions',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                        'Secure, convenient and reliable mobility solutions for your business and guests.'),
                    const SizedBox(height: 24),
                    Row(children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Get Started')),
                      const SizedBox(width: 12),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('Learn more')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
