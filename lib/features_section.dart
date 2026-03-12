import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'section_box.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  Future<String> _loadContent() async {
    return await rootBundle.loadString('assets/content/features.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
      child: Column(
        children: [
          Text(
            'Services',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          FutureBuilder<String>(
            future: _loadContent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('What We Offer');
              }
              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(builder: (context, constraints) {
            final columns = constraints.maxWidth > 900
                ? 3
                : (constraints.maxWidth > 600 ? 2 : 1);
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                  3,
                  (i) => SizedBox(
                      width: (constraints.maxWidth / columns) - 24,
                      child: FeatureCard(index: i))),
            );
          })
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final int index;
  const FeatureCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final titles = ['Secure Lots', '24/7 Support', 'Easy Booking'];
    final desc = [
      'Monitored parking areas',
      'Always on call for customers',
      'Book in seconds online'
    ];
    return SectionBox(
      backgroundColor: Colors.white,
      icon: [Icons.lock, Icons.headset_mic, Icons.book_online][index],
      title: titles[index],
      child: Text(desc[index]),
    );
  }
}
