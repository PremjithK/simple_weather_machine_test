import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

class ErrorMessageCard extends StatelessWidget {
  const ErrorMessageCard({
    super.key,
    required this.message,
    required this.icon,
  });
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 360.w,
          height: 100.h,
          padding: MainCardLayout.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MainCardLayout.borderRadius,
            ),
            color: Colors.red.shade600.withOpacity(0.7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.red.shade100,
              ),
              wSpace(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      color: Colors.red.shade100,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
