import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.mobile, required this.tablet, required this.desktop});

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;  // Mobile
        } else if (constraints.maxWidth < 1024) {
          return tablet;  // Tablet
        } else {
          return desktop; // Desktop
        }
      },
    );
  }
}
