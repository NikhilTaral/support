import 'package:flutter/material.dart';

enum ResponsiveSize {
  mobile,
  tablet,
  desktop,
}

class Responsive extends StatelessWidget {
  static double mobileWidth = 475.0;
  static double tabletWidth = 768.0;
  static double desktopWidth = 1386.0;

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobileSize() => _currentSize == ResponsiveSize.mobile;
  static bool isTabletSize() => _currentSize == ResponsiveSize.tablet;
  static bool isDesktopSize() => _currentSize == ResponsiveSize.desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletWidth &&
      MediaQuery.of(context).size.width < desktopWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;

  static ResponsiveSize responsiveSize(BuildContext context) {
    if (isMobile(context)) {
      return ResponsiveSize.mobile;
    } else if (isTablet(context)) {
      return ResponsiveSize.tablet;
    } else {
      return ResponsiveSize.desktop;
    }
  }

  static ResponsiveSize _currentSize = ResponsiveSize.desktop;

  static void update(BuildContext context) {
    if (isMobile(context)) {
      _currentSize = ResponsiveSize.mobile;
    } else if (isTablet(context)) {
      _currentSize = ResponsiveSize.tablet;
    } else {
      _currentSize = ResponsiveSize.desktop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= desktopWidth) {
          return desktop;
        } else if (constraints.maxWidth >= tabletWidth) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
