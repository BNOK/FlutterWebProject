import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

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
  final PageController _bgPageController = PageController();
  final ScrollController _scrollController = ScrollController();

  // keys for scrolling to sections
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  int _currentBgPage = 0;
  Timer? _bgTimer;
  int _bgAutoIndex = 0;
  List<String> _bgImages = [];

  @override
  void initState() {
    super.initState();
    _loadBgImages();
  }

  @override
  void dispose() {
    _bgTimer?.cancel();
    _bgPageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadBgImages() async {
    String manifestContent;
    Future<String> tryPaths(List<String> paths) async {
      for (var p in paths) {
        try {
          return await rootBundle.loadString(p);
        } catch (_) {}
      }
      throw Exception('could not load asset manifest');
    }

    manifestContent = await tryPaths([
      'AssetManifest.json',
      'assets/AssetManifest.json',
      'AssetManifest.bin.json',
      'assets/AssetManifest.bin.json',
      'AssetManifest.bin',
      'assets/AssetManifest.bin',
    ]);

    final trimmed = manifestContent.trim();
    if (!trimmed.startsWith('{') &&
        trimmed.contains(RegExp(r'^[A-Za-z0-9+/=\r\n]+$'))) {
      try {
        manifestContent = utf8.decode(base64.decode(trimmed));
      } catch (_) {}
    }

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final images = manifestMap.keys
        .where((String key) => key.startsWith('assets/images/'))
        .toList();
    setState(() {
      _bgImages = images;
    });

    if (_bgImages.isNotEmpty) {
      _startBgAutoSlide();
    }
  }

  void _startBgAutoSlide() {
    _bgTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_bgImages.isEmpty) return;
      _bgPageController.animateToPage(_bgAutoIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _bgAutoIndex = (_bgAutoIndex + 1) % _bgImages.length;
    });
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
                      // background or gradient fallback
                      Positioned.fill(
                        child: _bgImages.isNotEmpty
                            ? PageView.builder(
                                controller: _bgPageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _bgImages.length,
                                onPageChanged: (p) =>
                                    setState(() => _currentBgPage = p),
                                itemBuilder: (context, index) {
                                  final path = _bgImages[index];
                                  if (path.toLowerCase().endsWith('.svg')) {
                                    return SvgPicture.asset(path,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity);
                                  }
                                  return Image.asset(path,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity);
                                },
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlue.shade50,
                                      Colors.white,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                      ),
                      Positioned.fill(
                        child: Container(color: Colors.black.withOpacity(0.2)),
                      ),
                      const HeroSection(),
                      if (_bgImages.isNotEmpty)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _bgImages.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  _bgPageController.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentBgPage == index
                                        ? Colors.white
                                        : Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
