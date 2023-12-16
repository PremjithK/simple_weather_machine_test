import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/config/config.dart';
import 'package:simple_weather/data/forecast_model.dart' as fc;
import 'package:simple_weather/domain/geo_locator.dart';
import 'package:simple_weather/domain/weather_repository.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/home_screen/weather_bloc/weather_bloc.dart';
import 'package:simple_weather/ui/home_screen/forecast_bloc/forecast_bloc.dart';
import 'package:simple_weather/ui/widgets/city_entry_field.dart';
import 'package:simple_weather/ui/widgets/error_message_card.dart';
import 'package:simple_weather/ui/widgets/forecast_card.dart';
import 'package:simple_weather/ui/widgets/forecast_loading_indicator.dart';
import 'package:simple_weather/ui/widgets/notice_text.dart';
import 'package:simple_weather/ui/widgets/my_elevated_button.dart';
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

    periodicFetch();
  }

  //^ Periodically Fetching current weather information
  void periodicFetch() {
    Timer.periodic(const Duration(seconds: 60), (Timer timer) {
      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent());
      print('Periodic fetch triggered');
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.autumBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: PageLayout.screenPadding,
          physics: const BouncingScrollPhysics(),
          children: [
            hSpace(40),
            Center(
              child: Text(
                'Simple Weather App',
                style: GoogleFonts.instrumentSans(
                  fontSize: 20.sp,
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            hSpace(15),
            // Current Weather
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
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
                  return Column(
                    children: [
                      ErrorMessageCard(
                        message: state.message,
                        icon: Icons.location_off_sharp,
                      ),
                      hSpace(5),
                      MyElevatedButton(
                        label: 'Retry',
                        icon: const Icon(Icons.repeat),
                        onPressed: () => BlocProvider.of<WeatherBloc>(context)
                            .add(FetchWeatherEvent()),
                      ),
                    ],
                  );
                }

                return const ErrorMessageCard(
                  message: 'Could not get location data',
                  icon: Icons.location_off_sharp,
                );
              },
            ),

            // Forecast City Picker
            hSpace(20),
            Form(
              key: _formKey,
              child: CityEntryField(
                autofillEntries: const [
                  'Kozhikode',
                  'Kannur',
                  'Kochi',
                ],
                controller: _cityController,
                onChanged: (value) {
                  if (value == '') {
                    forecastBloc.add(ForecastClearEvent());
                  }
                },
                onSubmit: () {
                  if (_formKey.currentState!.validate()) {
                    forecastBloc.add(ForecastFetchEvent(
                      cityName: _cityController.text.trim(),
                    ));
                    // Dismissing the keyboard on submit
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),
            // 5 Day Forecast
            hSpace(20),
            BlocBuilder<ForecastBloc, ForecastState>(
              bloc: forecastBloc,
              builder: (_, state) {
                if (state is ForecastInitial) {
                  return const Center(
                    child: NoticeDisplay(
                      title: 'Note',
                      message:
                          '''Type a city name or country and hit the send button to fetch the forecast for that city.
eg:  Kochi, Kannur, Tokyo...''',
                    ),
                  );
                } else if (state is ForecastCleared) {
                  return const SizedBox();
                } else if (state is ForecastLoading) {
                  return const Center(
                    child: ForecastLoadingIndicator(),
                  );
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
                        // filtering out certain records to get unique day
                        final fIndex = index % 8 == 0;
                        final item = data.list[index];
                        return (fIndex)
                            ? ForecastCard(data: item)
                            : const SizedBox();
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
    );
  }
}
