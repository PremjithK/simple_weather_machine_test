import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/data/current_weather_model.dart';
import 'package:simple_weather/theme/layout.dart';
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
    Color textColor = const Color(0xFFF6C8A4);
    final TextStyle mainHeading = GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: textColor,
    );

    final TextStyle mainTemperature = GoogleFonts.poppins(
      fontSize: 90.sp,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 1.1,
    );
    final TextStyle mainWeather = GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final TextStyle mainLocationName = GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final TextStyle mainDate = GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: textColor,
    );
    final TextStyle mainFeelsLike = GoogleFonts.poppins(
      fontSize: 16.sp,
      color: textColor,
    );

    //! UI
    return Container(
      width: 360,
      height: 280.h,
      padding: MainCardLayout.padding,
      decoration: BoxDecoration(
        color: const Color(0xFFAC736A),
        borderRadius: BorderRadius.circular(
          MainCardLayout.borderRadius + 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Today', style: mainHeading),
          hSpace(5),
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
              Text(
                // Large Temperature font
                '${weather.main.temp.round()}°',
                style: mainTemperature,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
          Text(
            // Weather state name
            weather.weather[0].main,
            style: mainWeather,
          ),
          Text(
            // DateTime
            DateFormat('EEEE dd').format(DateTime.now()),
            style: mainDate,
          ),
          hSpace(10),
          Text(
            // Location name (from geolocator)
            weather.name,
            style: mainLocationName,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                // feels like temperature
                'Feels like ${weather.main.feelsLike.round()}°C',
                style: mainFeelsLike,
              ),
              Text(
                // weather description
                ' | ${weather.weather[0].description}',
                style: mainFeelsLike,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
