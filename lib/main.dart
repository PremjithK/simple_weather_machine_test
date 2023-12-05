import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/domain/weather_repository.dart';
import 'package:simple_weather/ui/home_screen/bloc/weather_bloc.dart';
import 'package:simple_weather/ui/home_screen/forecast_bloc/forecast_bloc.dart';
import 'package:simple_weather/ui/home_screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherBloc(
            WeatherRepository(),
          )..add((FetchWeatherEvent())),
        ),
        BlocProvider(create: (_) => ForecastBloc(WeatherRepository())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(436, 842),
        builder: (context, _) => const MaterialApp(
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          title: 'Simple Weather App',
          home: HomeScreen(),
        ),
      ),
    );
  }
}
