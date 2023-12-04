part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class CurrentWeatherFetchEvent extends CurrentWeatherEvent {
  final double lat;
  final double long;
  const CurrentWeatherFetchEvent(
    this.lat,
    this.long,
  );
}
