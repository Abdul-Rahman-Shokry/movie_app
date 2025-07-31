import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/constants.dart';
import '../../../core/models/movie_details.dart';
import '../../../core/models/cast.dart';
import '../../../core/models/crew.dart';
import '../models/movie_details_data.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final ApiClient _apiClient;

  MovieDetailsCubit(this._apiClient) : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final detailsResponse = await _apiClient.dio.get(
        AppConstants.movieDetailsPath(movieId),
      );
      final creditsResponse = await _apiClient.dio.get(
        '${AppConstants.movieDetailsPath(movieId)}/credits',
      );
      final videosResponse = await _apiClient.dio.get(
        '${AppConstants.movieDetailsPath(movieId)}/videos',
      );

      final MovieDetails details = MovieDetails.fromJson(detailsResponse.data);

      final List<Cast> cast = (creditsResponse.data['cast'] as List)
          .map((json) => Cast.fromJson(json))
          .toList();
      final List<Crew> crew = (creditsResponse.data['crew'] as List)
          .map((json) => Crew.fromJson(json))
          .toList();

      String? trailerKey;
      final List videos = videosResponse.data['results'] as List;
      // Find the first trailer from YouTube
      final trailer = videos.firstWhere(
        (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
        orElse: () => null,
      );
      if (trailer != null) {
        trailerKey = trailer['key'];
      }

      final movieDetailsData = MovieDetailsData(
        details: details,
        cast: cast,
        crew: crew,
        trailerKey: trailerKey,
      );

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
