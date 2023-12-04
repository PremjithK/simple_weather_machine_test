import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/config/config.dart';
import 'package:simple_weather/data/current_weather_model.dart';
import 'package:simple_weather/domain/geo_locator.dart';
import 'package:simple_weather/domain/weather_repository.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/home_screen/bloc/current_weather_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    weatherBloc = WeatherBloc(WeatherRepository());
    getDeviceLocation();
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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
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
                      final CurrentWeather weatherData = state.weather;
                      return Flexible(
                        flex: 2,
                        child: WeatherDisplay(
                          weather: weatherData,
                        ),
                      );
                    } else if (state is WeatherErrorState) {
                      return const Text('An error occured');
                    }
                    return const Text('An error occured');
                  },
                ),
                hSpace(20),
                // 5 Day Forecast
                const Flexible(
                  flex: 2,
                  child: ForecastCard(),
                ),

                // Quotes section
                const Spacer()
                // const Flexible(
                //   flex: 2,
                //   child: SizedBox(),
                // ),
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
}
