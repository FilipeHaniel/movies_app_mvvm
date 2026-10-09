import 'package:dio/dio.dart';
import 'package:movies_app_mvvm/core/errors/failures.dart';
import 'package:movies_app_mvvm/core/network/http_client.dart';

class HttpClientImpl implements IHttpClient {
  final Dio dio;

  HttpClientImpl({required this.dio});

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
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
