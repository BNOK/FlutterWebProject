import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart' as cs;
//import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A full‑screen carousel that loads whatever images live under
/// `assets/images/` and cycles them automatically.  It
/// exposes a [CarouselController] so callers can manipulate the
/// active page, and optionally renders a set of page indicators.
///
/// The widget handles the fairly messy `AssetManifest` logic that is
/// necessary on web; callers simply instantiate the widget and stick
/// it behind their content.
class CarouselBackground extends StatefulWidget {
  /// Controller that can be used to programmatically change pages.
  final cs.CarouselSliderController controller;

  /// Whether or not an indicator row should be shown at the bottom of
  /// the carousel.  Defaults to `false`.
  final bool showIndicators;

  /// Callback invoked whenever the page changes.
  final ValueChanged<int>? onPageChanged;

  const CarouselBackground({
    Key? key,
    required this.controller,
    this.showIndicators = false,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _CarouselBackgroundState createState() => _CarouselBackgroundState();
}

class _CarouselBackgroundState extends State<CarouselBackground> {
  List<String> _images = [];
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
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

      if (images.isNotEmpty) {
        setState(() {
          _images = images;
        });
      }
    } catch (e) {
      debugPrint('CarouselBackground: Failed to load images - $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      // fallback gradient while assets are loading or if none found
      return Container(
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
      );
    }

    return Stack(
      children: [
        cs.CarouselSlider.builder(
          carouselController: widget.controller,
          itemCount: _images.length,
          itemBuilder: (context, index, realIdx) {
            final path = _images[index];
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
          options: cs.CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
              widget.onPageChanged?.call(index);
            },
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
        if (widget.showIndicators && _images.isNotEmpty)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
                (index) => GestureDetector(
                  onTap: () {
                    widget.controller.animateToPage(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.white
                          : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
