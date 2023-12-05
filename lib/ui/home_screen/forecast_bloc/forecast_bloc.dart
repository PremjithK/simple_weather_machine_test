import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String unit = prefs.getString('unit') ?? 'metric';
      if (!await Geolocator.isLocationServiceEnabled()) {
        emit(
          const ForecastError(message: 'Location services are not enabled'),
        );
      }
      final cityName = event.cityName;
      final Response response = await _repository.fetchForecast(
        city: cityName,
        unit: unit,
      );
      if (response.statusCode == 200) {
        final ForecastData data = forecastDataFromJson(
          jsonEncode(response.data),
        );
        emit(ForecastLoaded(forecast: data));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
