part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherInitialEvent extends WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {}

class NoLocationAccessEvent extends WeatherEvent {}
