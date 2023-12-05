part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastCleared extends ForecastState {}

final class ForecastLoaded extends ForecastState {
  final ForecastData forecast;

  const ForecastLoaded({required this.forecast});
  @override
  List<Object> get props => [forecast];
}

final class ForecastError extends ForecastState {
  final String message;
  const ForecastError({required this.message});
}
