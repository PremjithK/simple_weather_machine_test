import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

class NoticeDisplay extends StatelessWidget {
  const NoticeDisplay({
    super.key,
    required this.title,
    required this.meessage,
  });

  final String title;
  final String meessage;

  @override
  Widget build(BuildContext context) {
    final textShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.6),
        blurRadius: 15,
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
            fontSize: 25.sp,
            shadows: textShadow,
          ),
        ),
        hSpace(5),
        Text(
          meessage,
          maxLines: 5,
          style: GoogleFonts.instrumentSans(
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.75),
            fontSize: 18.sp,
            shadows: textShadow,
          ),
        ),
      ],
    );
  }
}
