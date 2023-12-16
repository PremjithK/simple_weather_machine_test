import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.icon,
  });

  final String label;
  final Widget icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        label,
        style: GoogleFonts.instrumentSans(
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: icon,
      style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.black),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(MainCardLayout.borderRadius - 7),
              ),
            ),
          )),
      onPressed: onPressed,
    );
  }
}
