import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/theme/layout.dart';

class ForecastLoadingIndicator extends StatelessWidget {
  const ForecastLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey.shade600.withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                MainCardLayout.borderRadius,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(
                  color: Colors.grey.shade300.withOpacity(0.75),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
