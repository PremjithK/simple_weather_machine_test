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
    required this.autofillEntries,
    this.onChanged,
    this.focusNode,
  });

  final List<String> autofillEntries;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function() onSubmit;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
              MainCardLayout.borderRadius,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
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
                    fontSize: 16.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                  ),
                  canRequestFocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    isDense: true,
                    errorMaxLines: 1,
                    hintText: 'Enter City Name',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.25),
                    ),
                    border: InputBorder.none,
                    errorStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      height: 0,
                      color: Colors.red.shade400,
                    ),
                  ),
                  focusNode: focusNode,
                  cursorColor: Colors.white,
                  autofillHints: autofillEntries,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == '') {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                  onChanged: onChanged,
                ),
              ),
              wSpace(15),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                splashRadius: 20,
                color: Colors.black,
                onPressed: onSubmit,
                icon: const Icon(
                  Icons.send,
                  size: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
