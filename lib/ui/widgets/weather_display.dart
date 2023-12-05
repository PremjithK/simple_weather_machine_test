import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/data/current_weather_model.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/color_from_weather.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';
import 'package:simple_weather/ui/widgets/weather_state_icon.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({
    super.key,
    required this.weather,
  });
  final CurrentWeather weather;
  @override
  Widget build(BuildContext context) {
    Color textColor = colorsFromWeather(weather: weather.weather[0].main)['text']!;
    final TextStyle mainHeading = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: textColor,
    );
    final TextStyle unitSign = GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final TextStyle mainTemperature = GoogleFonts.inter(
      fontSize: 80.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
      height: 0,
      letterSpacing: -2.5,
    );
    final TextStyle mainWeather = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final TextStyle mainLocationName = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final TextStyle mainDate = GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: textColor,
    );
    final TextStyle mainFeelsLike = GoogleFonts.inter(
      fontSize: 16.sp,
      color: textColor,
    );

    //! UI
    return BackdropFilter(
      filter: ColorFilter.mode(
        colorsFromWeather(weather: weather.weather[0].main)['bg']!,
        BlendMode.colorBurn,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 360,
            height: 280.h,
            padding: MainCardLayout.padding,
            decoration: BoxDecoration(
              color: colorsFromWeather(
                weather: weather.weather[0].main,
              )['bg']!
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                MainCardLayout.borderRadius + 5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Today', style: mainHeading),
                Text(
                  DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now()),
                  style: mainDate,
                ),
                hSpace(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      showWeatherIcon(name: weather.weather[0].main),
                      color: textColor,
                      size: 80,
                    ),
                    wSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${weather.main.temp.round()}°',
                          style: mainTemperature,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(
                          height: 50.h,
                          child: Text('C', style: unitSign),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  weather.weather[0].main,
                  style: mainWeather,
                ),
                hSpace(10),
                Text(
                  weather.name,
                  style: mainLocationName,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Feels like ${weather.main.feelsLike.round()}°C',
                      style: mainFeelsLike,
                    ),
                    Text(
                      ' | ${weather.weather[0].description}',
                      style: mainFeelsLike,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
