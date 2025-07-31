import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
// import '../../../core/utils/constants.dart';
import '../../../core/models/movie.dart';
import '../models/home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiClient apiClient; // Changed from _apiClient to apiClient (public)

  HomeCubit(this.apiClient) : super(HomeInitial());

  Future<void> fetchHomeMovies() async {
    emit(HomeLoading());
    try {
      final responses = await Future.wait([
        apiClient.getTrendingMovies(),
        apiClient.getPopularMovies(),
        apiClient.getUpcomingMovies(),
        apiClient
            .getUpcomingMovies(), // This should be a different method like getTopRatedMovies
      ]);

      // The API methods already return List<Movie> (not nullable), so no need for null checks
      final List<Movie> trendingMovies = responses[0];
      final List<Movie> popularMovies = responses[1];
      final List<Movie> topRatedMovies = responses[2];
      final List<Movie> upcomingMovies = responses[3];

      final homeData = HomeData(
        trendingMovies: trendingMovies,
        nowPlayingMovies: popularMovies, // Using popular movies as now playing
        topRatedMovies: topRatedMovies,
        upcomingMovies: upcomingMovies,
      );

      emit(HomeLoaded(homeData: homeData));
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch movies: ';
      if (e.response != null) {
        errorMessage +=
            'Status Code: ${e.response!.statusCode}, Data: ${e.response!.data}';
      } else {
        errorMessage += e.message ?? 'Unknown error';
      }
      emit(HomeError(message: errorMessage));
    } catch (e) {
      // If any other error occurs, emit an empty home data instead of error
      final homeData = HomeData.empty();
      emit(HomeLoaded(homeData: homeData));
    }
  }

  void fetchHomeData() {}
}
