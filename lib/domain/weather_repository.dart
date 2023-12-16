import 'package:dio/dio.dart';
import 'package:simple_weather/config/config.dart';

class WeatherRepository {
  final Dio _dio = Dio();

  Future<dynamic> fetchWeather(
    double lat,
    double long,
    String unit,
  ) async {
    Map<String, dynamic> params = {
      'lat': lat,
      'lon': long,
      'appid': Api.key,
      'units': unit,
    };

    final Response response = await _dio.get(
      '${Api.baseURL}/weather',
      queryParameters: params,
    );

    return response;
  }

  Future<dynamic> fetchForecast({
    required String city,
    required String unit,
  }) async {
    final Response response = await _dio.get(
      '${Api.baseURL}/forecast',
      options: Options(
        persistentConnection: true,
      ),
      queryParameters: {
        'appid': Api.key,
        'q': city,
        'units': unit,
      },
    );
    return response;
  }
}
