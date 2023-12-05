import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/data/forecast_model.dart' as fc;
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/color_from_weather.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';
import 'package:simple_weather/ui/widgets/weather_state_icon.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.data,
  });
  final fc.ListElement data;

  @override
  Widget build(BuildContext context) {
    final status = data.weather[0].main.name;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            height: 100.h,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: colorsFromWeather(
                weather: status,
              )['bg']!
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                MainCardLayout.borderRadius,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      showWeatherIcon(name: data.weather[0].main.name),
                      color: Colors.white,
                      size: 50.sp,
                    ),
                    wSpace(5),
                    Text(
                      '${data.main.temp.round().toString()}°',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 50.sp,
                        height: 0,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        //date field
                        DateFormat('yyyy-MM-dd').format(data.dtTxt),
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      hSpace(5),
                      Text(
                        //date field
                        data.weather[0].main.name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),
                      hSpace(5),
                      Row(
                        children: [
                          Text(
                            //date field
                            'MAX ${data.main.tempMax.round().toString()}°',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          wSpace(10),
                          Text(
                            //date field
                            'MIN ${data.main.tempMin.round().toString()}°',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
