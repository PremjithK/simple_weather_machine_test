import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

class NoticeDisplay extends StatelessWidget {
  const NoticeDisplay({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final textShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.8),
        spreadRadius: 5,
        blurRadius: 30,
      )
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: GoogleFonts.instrumentSans(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 21.sp,
            shadows: textShadow,
          ),
        ),
        hSpace(5),
        Text(
          message,
          maxLines: 5,
          style: GoogleFonts.instrumentSans(
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.75),
            fontSize: 16.sp,
            shadows: textShadow,
          ),
        ),
      ],
    );
  }
}
