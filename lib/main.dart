import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/ui/home_screen/bloc/current_weather_bloc.dart';
import 'package:simple_weather/ui/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CurrentWeatherBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, _) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Weather App',
          home: HomeScreen(),
        ),
      ),
    );
  }
}
