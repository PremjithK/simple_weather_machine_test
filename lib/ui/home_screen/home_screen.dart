import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/config/config.dart';
import 'package:simple_weather/data/forecast_model.dart' as fc;
import 'package:simple_weather/domain/geo_locator.dart';
import 'package:simple_weather/domain/weather_repository.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/home_screen/bloc/weather_bloc.dart';
import 'package:simple_weather/ui/home_screen/forecast_bloc/forecast_bloc.dart';
import 'package:simple_weather/ui/widgets/city_entry_field.dart';
import 'package:simple_weather/ui/widgets/error_message_card.dart';
import 'package:simple_weather/ui/widgets/forecast_card.dart';
import 'package:simple_weather/ui/widgets/weather_display.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';
import 'package:simple_weather/ui/widgets/weather_loading.dart';

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
    getDeviceLocation();
    weatherBloc = WeatherBloc(WeatherRepository());
    forecastBloc = ForecastBloc(WeatherRepository());
    periodicFetch(weatherBloc);
  }

  void periodicFetch(WeatherBloc weatherBloc) {
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      weatherBloc.add(FetchWeatherEvent());
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();

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
        // Appbar
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            padding: PageLayout.screenPadding,
            physics: const BouncingScrollPhysics(),
            children: [
              hSpace(50),
              // Current Weather
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (_, state) {
                  if (state is WeatherInitialState) {
                    return const WeatherLoadingCard();
                  } else if (state is WeatherLoadedState) {
                    return Center(
                      child: WeatherDisplay(
                        weather: state.weather,
                      ),
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
                    message: 'Unexpected error occured',
                    icon: Icons.location_off_sharp,
                  );
                },
              ),

              // Forecast City Picker
              hSpace(20),
              Form(
                key: _formKey,
                child: CityEntryField(
                  controller: _cityController,
                  onSubmit: () {
                    if (_formKey.currentState!.validate()) {
                      forecastBloc.add(ForecastFetchEvent(
                        cityName: _cityController.text.trim(),
                      ));
                    }
                  },
                ),
              ),
              // 5 Day Forecast
              hSpace(20),
              BlocBuilder<ForecastBloc, ForecastState>(
                bloc: forecastBloc,
                builder: (context, state) {
                  if (state is ForecastInitial) {
                    return const SizedBox();
                  } else if (state is ForecastLoaded) {
                    final fc.ForecastData data = state.forecast;

                    return SizedBox(
                      width: 360.w,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.list.length,
                        itemBuilder: (context, index) {
                          final fIndex = index % 8 == 0;
                          final item = data.list[index];
                          return (fIndex) ? ForecastCard(data: item) : const SizedBox();
                        },
                      ),
                    );
                  } else if (state is ForecastError) {
                    return ErrorMessageCard(
                      message: state.message,
                      icon: Icons.error,
                    );
                  }
                  return const ErrorMessageCard(
                    message: 'Unexpected Error Occured',
                    icon: Icons.error,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
