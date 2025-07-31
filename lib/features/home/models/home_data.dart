import '../../../core/models/movie.dart';

class HomeData {
  final List<Movie> trendingMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  HomeData({
    required this.trendingMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });

  factory HomeData.empty() => HomeData(
    trendingMovies: [],
    nowPlayingMovies: [],
    topRatedMovies: [],
    upcomingMovies: [],
  );

  HomeData copyWith({
    List<Movie>? trendingMovies,
    List<Movie>? nowPlayingMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
  }) {
    return HomeData(
      trendingMovies: trendingMovies ?? this.trendingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
    );
  }
}
