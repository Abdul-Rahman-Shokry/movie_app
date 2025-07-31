class AppConstants {
  static const String tmdbApiKey = '2ad79a57b7f4607058a68cfdd3620540';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Endpoints
  static const String trendingMoviesPath = '/trending/movie/day';
  static const String nowPlayingMoviesPath = '/movie/now_playing';
  static const String topRatedMoviesPath = '/movie/top_rated';
  static const String upcomingMoviesPath = '/movie/upcoming';
  static String movieDetailsPath(int movieId) => '/movie/$movieId';
  static String searchMoviesPath(String query) => '/search/movie?query=$query';
  static const String genresListPath = '/genre/movie/list';
}
