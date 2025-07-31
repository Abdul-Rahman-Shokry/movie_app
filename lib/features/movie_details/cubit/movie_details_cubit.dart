import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/movie_details_data.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final ApiClient _apiClient;

  MovieDetailsCubit(this._apiClient) : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetailsData = await _apiClient.getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movieDetailsData: movieDetailsData));
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch movie details: ';
      if (e.response != null) {
        errorMessage +=
            'Status Code: ${e.response!.statusCode}, Data: ${e.response!.data}';
      } else {
        errorMessage += e.message ?? 'Unknown error';
      }
      emit(MovieDetailsError(message: errorMessage));
    } catch (e) {
      emit(
        MovieDetailsError(
          message: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }
}
