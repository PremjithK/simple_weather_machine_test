part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class ForecastInitialEvent extends ForecastEvent {}

class ForecastFetchEvent extends ForecastEvent {
  final String cityName;

  const ForecastFetchEvent({required this.cityName});
}
