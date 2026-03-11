import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'carousel_background.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'top_nav.dart';
import 'hero_section.dart';
import 'features_section.dart';
import 'about_section.dart';
import 'contact_section.dart';
import 'footer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  final ScrollController _scrollController = ScrollController();

  // keys for scrolling to sections
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  // handle nav button clicks
  void _handleNav(String label) {
    switch (label) {
      case 'Home':
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        break;
      case 'Services':
        _scrollToKey(_featuresKey);
        break;
      case 'About':
        _scrollToKey(_aboutKey);
        break;
      case 'Contact':
        _scrollToKey(_contactKey);
        break;
    }
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const navHeight = 80.0;
    final sectionHeight = screenHeight - navHeight;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: navHeight),
            child: Column(
              children: [
                // top hero area with carousel background (full screen minus nav)
                SizedBox(
                  height: sectionHeight,
                  child: Stack(
                    children: [
                      // full‑screen carousel widget handles its own fallback/asset loading
                      Positioned.fill(
                        child: CarouselBackground(
                          controller: _carouselController,
                          showIndicators: true,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(color: Colors.black.withOpacity(0.2)),
                      ),
                      const HeroSection(),

                    ],
                  ),
                ),
                // remaining sections with white background
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                          key: _featuresKey,
                          child: SizedBox(
                              height: sectionHeight,
                              child: const FeaturesSection())),
                      Container(
                          key: _aboutKey,
                          child: SizedBox(
                              height: sectionHeight,
                              child: const AboutSection())),
                      Container(
                          key: _contactKey,
                          child: SizedBox(
                              height: sectionHeight,
                              child: const ContactSection())),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          // fixed navbar on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
                height: navHeight, child: TopNav(onItemSelected: _handleNav)),
          ),
        ],
      ),
    );
  }
}
