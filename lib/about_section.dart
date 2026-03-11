import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'section_box.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<String> _loadVision() async =>
      await rootBundle.loadString('assets/content/about_vision.txt');
  Future<String> _loadActivity() async =>
      await rootBundle.loadString('assets/content/about_activity.txt');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'About Us',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          // two light blue boxes
          Row(
            children: [
              Expanded(
                child: SectionBox(
                  icon: Icons.remove_red_eye,
                  title: 'Our Vision',
                  backgroundColor: Colors.lightBlue.shade50,
                  child: FutureBuilder<String>(
                    future: _loadVision(),
                    builder: (context, snap) {
                      if (snap.hasData) return Text(snap.data!);
                      if (snap.hasError) return const Text('');
                      return const SizedBox(
                          height: 24, child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SectionBox(
                  icon: Icons.work,
                  title: 'Our Activity',
                  backgroundColor: Colors.lightBlue.shade50,
                  child: FutureBuilder<String>(
                    future: _loadActivity(),
                    builder: (context, snap) {
                      if (snap.hasData) return Text(snap.data!);
                      if (snap.hasError) return const Text('');
                      return const SizedBox(
                          height: 24, child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
