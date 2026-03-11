# Flutter Web Landing Page Scaffold

This scaffold provides a minimal Flutter web app with a responsive landing page for VIONTECH.

Quick start:

```bash
# Ensure Flutter is installed and web is enabled
flutter config --enable-web
# From workspace root
cd d:/Projects/Web/Copilot
flutter pub get
flutter run -d chrome
```

Files created:
- `pubspec.yaml`
- `web/index.html`
- `lib/main.dart`
- `assets/` (placeholder)

Build for web:

```bash
# Install deps
flutter pub get
# Build release web bundle
flutter build web --release

# Serve locally (optional)
flutter run -d chrome
```

Deployment:

- Copy `build/web` contents to your static host (Netlify, Firebase Hosting, GitHub Pages, etc.).
- For GitHub Pages, create a branch with the `build/web` output or use actions to deploy.

Notes:
- Place images under `assets/images/` (a sample `assets/images/hero.svg` is included).
- If you want raster images instead of SVG, update `pubspec.yaml` asset paths accordingly.
