import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/data/current_weather_model.dart';
import 'package:simple_weather/domain/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _repository;

  WeatherBloc(this._repository) : super(WeatherInitialState()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  FutureOr<void> _fetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadingState());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String unit = prefs.getString('unit') ?? 'metric';
      if (!await Geolocator.isLocationServiceEnabled()) {
        emit(NoLocationAccessState());
      }

      final Position pos = await Geolocator.getCurrentPosition();
      final Response response = await _repository.fetchWeather(
        pos.latitude,
        pos.longitude,
        unit,
      );

      if (response.statusCode == 200) {
        final CurrentWeather data = currentWeatherFromJson(
          jsonEncode(response.data),
        );
        emit(WeatherLoadedState(weather: data));
      } else if (response.statusCode == 500) {
        emit(
          const WeatherErrorState(
            message: 'Server error occured. Try again later',
          ),
        );
      }
    } catch (err) {
      emit(const WeatherErrorState(message: 'Location Services are disabled'));
    }
  }
}
