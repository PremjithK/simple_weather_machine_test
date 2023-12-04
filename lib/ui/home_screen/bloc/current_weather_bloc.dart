import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurentWeatherInitial()) {
    on<CurrentWeatherEvent>((event, emit) {});
  }
}
