import 'package:dio/dio.dart';
import '../utils/constants.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.tmdbBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['api_key'] = AppConstants.tmdbApiKey;
          handler.next(options);
        },
        onError: (DioException e, handler) {
          print('Dio Error: ${e.response?.statusCode} - ${e.message}');
          handler.next(e);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  Dio get dio => _dio;
}
