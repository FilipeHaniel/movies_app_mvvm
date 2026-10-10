abstract class HttpClient {
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}

class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({required this.data, required this.statusCode});
}
