import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'section_box.dart';
import 'social_circle_icon.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<String> _loadContent() async {
    return await rootBundle.loadString('assets/content/contact.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Contact Us',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),
        SectionBox(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // two columns side by side
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Feel free to send us your message !',
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Your email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Send')),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(child: Text('Phone: +1‑800‑123‑4567')),
                          const SizedBox(height: 8),
                          const Center(
                              child: Text('Address: 123 Main St, Cityville')),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SocialCircleIcon(icon: Icons.video_library),
                              SizedBox(width: 12),
                              SocialCircleIcon(icon: Icons.facebook),
                              SizedBox(width: 12),
                              SocialCircleIcon(icon: Icons.camera_alt),
                              SizedBox(width: 12),
                              SocialCircleIcon(icon: Icons.link),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
