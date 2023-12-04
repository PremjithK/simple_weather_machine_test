import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_weather/theme/layout.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          width: 400.w,
          padding: MainCardLayout.padding,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
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
