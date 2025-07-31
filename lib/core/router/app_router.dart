import 'package:flutter/material.dart';
import '../../features/home/ui/home_screen.dart';

class AppRouter {
  static const String homeRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Text('Error: Unknown route'),
        );
    }
  }
}
