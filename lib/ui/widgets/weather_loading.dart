import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

class WeatherLoadingCard extends StatelessWidget {
  const WeatherLoadingCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 280.h,
      padding: MainCardLayout.padding,
      decoration: BoxDecoration(
        color: const Color(0xFFAC736A),
        borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            child: CircularProgressIndicator(
              color: Color(0xFFF6C8A4),
            ),
          ),
          hSpace(10),
          Text(
            'Getting location info...',
            style: GoogleFonts.inter(
              color: const Color(0xFFF6C8A4),
              fontSize: 20.sp,
            ),
          )
        ],
      ),
    );
  }
}
