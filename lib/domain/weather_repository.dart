import 'package:dio/dio.dart';
import 'package:simple_weather/config/config.dart';

class WeatherRepository {
  final Dio _dio = Dio();

  Future<dynamic> getWeatherByLocation({
    required double lat,
    required double long,
    required String unit,
  }) async {
    final Response response = await _dio.get(
      '${Api.baseURL}/weather',
      queryParameters: {
        'lat': lat,
        'lon': long,
        'appid': Api.key,
        'units': unit,
      },
    );
    return response;
  }

  Future<dynamic> getForecastByLocation({
    required double lat,
    required double long,
    required String unit,
  }) async {
    final Response response = await _dio.get(
      '${Api.baseURL}/forecast',
      queryParameters: {
        'lat': lat,
        'lon': long,
        'appid': Api.key,
        'units': unit,
      },
    );
    return response;
  }
}
