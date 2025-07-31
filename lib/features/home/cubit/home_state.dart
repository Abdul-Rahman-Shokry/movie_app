import '../models/home_data.dart';
import '../../../core/models/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData homeData;

  HomeLoaded({required this.homeData});

  List<Movie> get popularMovies =>
      homeData.nowPlayingMovies; // This is actually popular movies from the API

  List<Movie> get trendingMovies => homeData.trendingMovies;

  List<Movie> get upcomingMovies => homeData.upcomingMovies;
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
