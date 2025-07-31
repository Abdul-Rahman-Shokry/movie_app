// lib/core/api/api_client.dart

import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../../features/movie_details/models/movie_details_data.dart';
import '../utils/constants.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = AppConstants.tmdbBaseUrl;
    _dio.options.queryParameters = {
      'api_key': AppConstants.tmdbApiKey,
      'language': 'en-US',
    };
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );

      // Add more robust null checking and logging
      if (response.data == null) {
        print('API Response data is null for popular movies');
        return [];
      }

      final List<dynamic>? results = response.data['results'];
      if (results == null) {
        print('API Response results is null for popular movies');
        return [];
      }

      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      print('DioException in getPopularMovies: ${e.message}');
      throw Exception('Failed to load popular movies: ${e.message}');
    } catch (e) {
      print('Unexpected error in getPopularMovies: $e');
      throw Exception('Failed to load popular movies: $e');
    }
  }

  Future<List<Movie>> getTrendingMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/trending/movie/week',
        queryParameters: {'page': page},
      );

      if (response.data == null) {
        print('API Response data is null for trending movies');
        return [];
      }

      final List<dynamic>? results = response.data['results'];
      if (results == null) {
        print('API Response results is null for trending movies');
        return [];
      }

      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      print('DioException in getTrendingMovies: ${e.message}');
      throw Exception('Failed to load trending movies: ${e.message}');
    } catch (e) {
      print('Unexpected error in getTrendingMovies: $e');
      throw Exception('Failed to load trending movies: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );

      if (response.data == null) {
        print('API Response data is null for upcoming movies');
        return [];
      }

      final List<dynamic>? results = response.data['results'];
      if (results == null) {
        print('API Response results is null for upcoming movies');
        return [];
      }

      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      print('DioException in getUpcomingMovies: ${e.message}');
      throw Exception('Failed to load upcoming movies: ${e.message}');
    } catch (e) {
      print('Unexpected error in getUpcomingMovies: $e');
      throw Exception('Failed to load upcoming movies: $e');
    }
  }

  Future<MovieDetailsData> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId',
        queryParameters: {
          'append_to_response': 'videos,credits,recommendations',
        },
      );
      return MovieDetailsData.fromJson(response.data);
    } on DioException catch (e) {
      print('DioException in getMovieDetails: ${e.message}');
      throw Exception('Failed to load movie details: ${e.message}');
    } catch (e) {
      print('Unexpected error in getMovieDetails: $e');
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query, 'page': page},
      );

      if (response.data == null) {
        print('API Response data is null for search movies');
        return [];
      }

      final List<dynamic>? results = response.data['results'];
      if (results == null) {
        print('API Response results is null for search movies');
        return [];
      }

      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      print('DioException in searchMovies: ${e.message}');
      throw Exception('Failed to search movies: ${e.message}');
    } catch (e) {
      print('Unexpected error in searchMovies: $e');
      throw Exception('Failed to search movies: $e');
    }
  }
}
