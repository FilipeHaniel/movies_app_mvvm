abstract class ApiConfig {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static const String apiToken = String.fromEnvironment('TMDB_API_TOKEN');

  static Map<String, String> get defaultHeaders => {
    'Authorization': 'Bearer $apiToken',
    'accept': 'application/json',
  };
}
