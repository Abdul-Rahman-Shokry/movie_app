import 'package:flutter/material.dart';
import '../../features/home/ui/home_screen.dart';
import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../../features/movie_details/ui/movie_details_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String movieDetailsRoute = '/movie_details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case movieDetailsRoute:
        final args = settings.arguments;
        if (args is int) {
          return MaterialPageRoute(
            builder: (context) {
              return MovieDetailsScreen(
                movieId: args,
                apiClient: ApiClient(Dio()),
              );
            },
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Text('Error: Invalid movie ID'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Text('Error: Unknown route'),
        );
    }
  }
}
