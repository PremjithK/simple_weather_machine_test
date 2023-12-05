import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/data/forecast_model.dart';
import 'package:simple_weather/domain/weather_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository _repository;
  ForecastBloc(this._repository) : super(ForecastInitial()) {
    on<ForecastFetchEvent>(_fetchForecast);
  }

  FutureOr<void> _fetchForecast(
    ForecastFetchEvent event,
    Emitter<ForecastState> emit,
  ) async {
    if (event.cityName == '') {
      emit(const ForecastError(message: 'Invalid City Name'));
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String unit = prefs.getString('unit') ?? 'metric';

      final cityName = event.cityName;
      final Response response = await _repository.fetchForecast(
        city: cityName,
        unit: unit,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final ForecastData data = forecastDataFromJson(
          jsonEncode(response.data),
        );
        emit(ForecastLoaded(forecast: data));
      } else if (response.statusCode == 404) {
        emit(const ForecastError(message: 'City not found'));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        emit(ForecastError(message: 'City Not Found'));
      }
    } catch (e) {
      if (e is DioException) return;
      print(e);
      emit(const ForecastError(message: 'Unable to get forecast'));
    }
  }
}
