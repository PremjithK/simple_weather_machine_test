import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/config/config.dart';
// import 'package:simple_weather/domain/geo_locator.dart';
import 'package:simple_weather/domain/weather_repository.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/home_screen/bloc/weather_bloc.dart';
import 'package:simple_weather/ui/home_screen/forecast_bloc/forecast_bloc.dart';
import 'package:simple_weather/ui/widgets/error_message_card.dart';
import 'package:simple_weather/ui/widgets/forecast_card.dart';
import 'package:simple_weather/ui/widgets/weather_display.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherBloc weatherBloc;
  late ForecastBloc forecastBloc;
  @override
  void initState() {
    super.initState();
    weatherBloc = WeatherBloc(WeatherRepository());
    forecastBloc = ForecastBloc(WeatherRepository());
    // getDeviceLocation();
    periodicFetch(weatherBloc);
  }

  void periodicFetch(WeatherBloc weatherBloc) {
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      weatherBloc.add(FetchWeatherEvent());
    });
  }

  static const Axis pageDirection = Axis.vertical;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.fieldBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: PageLayout.screenPadding,
          child: Center(
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.start,
              direction: pageDirection,
              children: [
                // Current Weather
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (_, state) {
                    if (state is WeatherInitialState) {
                      return const CircularProgressIndicator();
                    } else if (state is WeatherLoadedState) {
                      // final CurrentWeather weatherData = state.weather;
                      print(state.weather.main.temp);
                      return WeatherDisplay(
                        weather: state.weather,
                      );
                    } else if (state is WeatherErrorState) {
                      return ErrorMessageCard(
                        message: state.message,
                        icon: Icons.location_off_sharp,
                      );
                    } else if (state is NoLocationAccessState) {
                      return const ErrorMessageCard(
                        message: 'Location unavailable',
                        icon: Icons.location_off_sharp,
                      );
                    }

                    return const ErrorMessageCard(
                      message: 'Location unavailable',
                      icon: Icons.location_off_sharp,
                    );
                  },
                ),
                hSpace(20),
                // 5 Day Forecast
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Forecast'),
                    TextButton.icon(
                      onPressed: () {
                        forecastBloc.add(const ForecastFetchEvent(cityName: 'Kochi'));
                      },
                      icon: Icon(Icons.location_pin),
                      label: Text('Change City'),
                    ),
                  ],
                ),
                BlocBuilder<ForecastBloc, ForecastState>(
                  bloc: forecastBloc,
                  builder: (context, state) {
                    if (state is ForecastInitial) {
                      return Text('No city selected');
                    } else if (state is ForecastLoaded) {
                      return ForecastCard(
                        forecast: state.forecast,
                      );
                    }
                    return Text('none');
                  },
                ),

                // Quotes section
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setUnits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('unit', 'metric');
  }

  _cityEntryDialog() {
    final _cityController = TextEditingController();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _cityController,
            ),
            ElevatedButton(
              onPressed: () {
                forecastBloc.add(
                  ForecastFetchEvent(
                    cityName: _cityController.text.trim(),
                  ),
                );
              },
              child: const Text('Select'),
            )
          ],
        ),
      ),
    );
  }
}
