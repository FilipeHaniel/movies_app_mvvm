import 'package:dio/dio.dart';
import 'package:movies_app_mvvm/core/config/api_config.dart';
import 'package:movies_app_mvvm/core/errors/failures.dart';
import 'package:movies_app_mvvm/core/network/http_client.dart';

class HttpClientImpl implements HttpClient {
  final Dio _dio;

  HttpClientImpl({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConfig.baseUrl,
              headers: ApiConfig.defaultHeaders,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure();
      }

      throw ServerFailure(
        e.message ?? 'Erro no servidor',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
