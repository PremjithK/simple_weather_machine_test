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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          width: 360.w,
          height: 280.h,
          padding: MainCardLayout.padding,
          decoration: BoxDecoration(
            color: Colors.brown.shade300.withOpacity(0.75),
            borderRadius: BorderRadius.circular(MainCardLayout.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.brown.shade600,
                ),
              ),
              hSpace(10),
              Text(
                'Getting location info...',
                style: GoogleFonts.inter(
                  color: Colors.brown.shade600,
                  fontSize: 20.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
