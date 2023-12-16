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
    print('fetch event');
    emit(WeatherLoadingState());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String unit = prefs.getString('unit') ?? 'metric';

      // Check if location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        emit(
          const NoLocationAccessState(
              message: 'Location service is disabled, try again'),
        );
        return;
      }

      // Check if location permission is granted
      final status = await Geolocator.checkPermission();
      if (status == LocationPermission.denied) {
        // Request location permission
        final permissionStatus = await Geolocator.requestPermission();
        if (permissionStatus != LocationPermission.whileInUse &&
            permissionStatus != LocationPermission.always) {
          emit(const WeatherErrorState(
            message:
                'Location permission denied. Unable to fetch weather data.',
          ));
          return;
        }
      }

      final Position pos = await Geolocator.getCurrentPosition();
      try {
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
        } else if (response.statusCode == 404) {
          emit(
            const WeatherErrorState(
                message: 'Could not get weather data of this location'),
          );
        } else if (response.statusCode == 500) {
          emit(
            const WeatherErrorState(
              message: 'Server error occured. Try again later',
            ),
          );
        }
      } catch (e) {
        emit(const WeatherErrorState(message: 'Error'));
      }
    } catch (err) {
      print(err);
      emit(
        const WeatherErrorState(message: 'Unexpected error occured'),
      );
    }
  }
}
