import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/constants.dart';
import '../../../core/models/movie.dart';
import '../models/home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiClient _apiClient;

  HomeCubit(this._apiClient) : super(HomeInitial());

  Future<void> fetchHomeMovies() async {
    emit(HomeLoading());
    try {
      final responses = await Future.wait([
        _apiClient.dio.get(AppConstants.trendingMoviesPath),
        _apiClient.dio.get(AppConstants.nowPlayingMoviesPath),
        _apiClient.dio.get(AppConstants.topRatedMoviesPath),
        _apiClient.dio.get(AppConstants.upcomingMoviesPath),
      ]);

      final List<Movie> trendingMovies = (responses[0].data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      final List<Movie> nowPlayingMovies =
          (responses[1].data['results'] as List)
              .map((json) => Movie.fromJson(json))
              .toList();
      final List<Movie> topRatedMovies = (responses[2].data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
      final List<Movie> upcomingMovies = (responses[3].data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();

      final homeData = HomeData(
        trendingMovies: trendingMovies,
        nowPlayingMovies: nowPlayingMovies,
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
      emit(HomeError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
