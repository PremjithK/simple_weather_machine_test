part of 'current_weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherInitialEvent extends WeatherEvent {}

class FetchWeatherByPosition extends WeatherEvent {}

class FetchWeatherByCity extends WeatherEvent {}
