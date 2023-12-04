import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';
import 'package:simple_weather/ui/widgets/weather_state_icon.dart';

class MainWeatherCard extends StatelessWidget {
  const MainWeatherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MainCardLayout.padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
      ),
      child: Column(
        children: [
          Text('Today', style: _mainHeading),
          Text('22-12-2024', style: _mainDate),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                showIcon(weatherName: 'Clouds'),
                size: 75,
              ),
              wSpace(10),
              Text('25C', style: _mainTemperature),
            ],
          ),
          Text('Cloudy', style: _mainWeather),
          Text('California LA', style: _mainLocationName),
          Text('Feels like 26C', style: _mainFeelsLike),
        ],
      ),
    );
  }
}

TextStyle _mainHeading = GoogleFonts.poppins(
  fontSize: 25.sp,
  fontWeight: FontWeight.w500,
);
TextStyle _mainTemperature = GoogleFonts.inter(
  fontSize: 75.sp,
  fontWeight: FontWeight.w900,
);
TextStyle _mainWeather = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
TextStyle _mainLocationName = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
TextStyle _mainDate = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
TextStyle _mainFeelsLike = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);
TextStyle _mainWeatherDescription = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);
