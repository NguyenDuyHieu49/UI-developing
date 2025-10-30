import 'package:flutter/material.dart';

// Centralized theme and layout constants for the app.
class AppTheme {
  // Maximum width to constrain content on wide screens (web/desktop).
  static const double maxContentWidth = 900.0;

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      // Use no page transitions so navigation appears instantly
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _NoTransitionsBuilder(),
          TargetPlatform.iOS: _NoTransitionsBuilder(),
          TargetPlatform.linux: _NoTransitionsBuilder(),
          TargetPlatform.macOS: _NoTransitionsBuilder(),
          TargetPlatform.windows: _NoTransitionsBuilder(),
        },
      ),
      // Small, consistent visual density for mobile and web
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Common text theme — keep defaults but expose the family here if needed later.
      textTheme: Typography.material2018().black,
    );
  }
}

class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
