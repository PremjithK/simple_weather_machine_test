import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/data/forecast_model.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/color_from_weather.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.forecast,
  });
  final ForecastData forecast;

  @override
  Widget build(BuildContext context) {
    final status = forecast.list[0].weather[0].main.name;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          width: 360.w,
          padding: MainCardLayout.padding,
          decoration: BoxDecoration(
            color: colorsFromWeather(weather: status)['bg'],
            borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}
