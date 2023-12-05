import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

class CityEntryField extends StatelessWidget {
  const CityEntryField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(
              MainCardLayout.borderRadius,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 7.5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  controller: controller,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    isDense: true,
                    errorMaxLines: 1,
                    hintText: 'Enter City Name',
                    border: InputBorder.none,
                    errorStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      height: 0,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == '') {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              wSpace(15),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                color: Colors.black,
                onPressed: onSubmit,
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
