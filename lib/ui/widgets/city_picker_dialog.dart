import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/theme/layout.dart';
import 'package:simple_weather/ui/home_screen/forecast_bloc/forecast_bloc.dart';
import 'package:simple_weather/ui/widgets/spacer.dart';

final _formKey = GlobalKey<FormState>();
cityEntryDialog(BuildContext context, ForecastBloc bloc) {
  final cityController = TextEditingController();

  return AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Container(
      padding: MainCardLayout.padding,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(
          MainCardLayout.borderRadius,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a city',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            hSpace(5),
            TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  )),
              controller: cityController,
            ),
            hSpace(10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(
                    ForecastFetchEvent(
                      cityName: cityController.text.trim(),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Select'),
            )
          ],
        ),
      ),
    ),
  );
}
