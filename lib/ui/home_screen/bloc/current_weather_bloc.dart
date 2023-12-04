import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/data/current_weather_model.dart';
import 'package:simple_weather/domain/weather_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repository;

  WeatherBloc(this._repository) : super(WeatherInitialState()) {
    on<FetchWeatherByPosition>(_fetchWeatherByPosition);
  }

  FutureOr<void> _fetchWeatherByPosition(
    FetchWeatherByPosition event,
    Emitter<WeatherState> emit,
  ) async {
    // emit(CurrentWeatherLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String unit = prefs.getString('unit') ?? 'metric';
      if (!await Geolocator.isLocationServiceEnabled()) emit(NoLocationAccessState());
      final Position pos = await Geolocator.getCurrentPosition();
      final Response response = await _repository.getWeatherByLocation(
        lat: pos.latitude,
        long: pos.longitude,
        unit: unit,
      );

      if (response.statusCode == 200) {
        final CurrentWeather data = currentWeatherFromJson(jsonEncode(response.data));
        emit(WeatherLoadedState(weather: data));
      } else {
        emit(WeatherErrorState());
      }
    } catch (err) {
      print(err);
      emit(WeatherErrorState());
    }
  }
}
