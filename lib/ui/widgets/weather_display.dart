import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final TextStyle mainHeading = GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    final TextStyle unitSign = GoogleFonts.inter(
      fontSize: 25.sp,
      fontWeight: FontWeight.bold,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    final TextStyle mainTemperature = GoogleFonts.instrumentSans(
      fontSize: 80.sp,
      fontWeight: FontWeight.bold,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
      height: 0,
      letterSpacing: -1,
    );
    final TextStyle mainWeather = GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    final TextStyle mainLocationName = GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    final TextStyle mainDate = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    final TextStyle mainFeelsLike = GoogleFonts.inter(
      fontSize: 16.sp,
      color: colorsFromWeather(weather: weather.weather[0].main)['text'],
    );
    return BackdropFilter(
      filter: ColorFilter.mode(
        colorsFromWeather(
          weather: weather.weather[0].main,
        )['bg']!
            .withOpacity(0.5),
        BlendMode.color,
      ),
      child: Container(
        width: 360.w,
        padding: MainCardLayout.padding,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
            ),
          ],
          color: colorsFromWeather(
            weather: weather.weather[0].main,
          )['bg'],
          borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Today', style: mainHeading),
            Text('${DateTime.now()}', style: mainDate),
            hSpace(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  showWeatherIcon(name: weather.weather[0].main),
                  color: colorsFromWeather(weather: weather.weather[0].main)['text'],
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
    );
  }
}
