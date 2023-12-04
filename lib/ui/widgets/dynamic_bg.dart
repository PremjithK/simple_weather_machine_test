import 'package:flutter/material.dart';
import 'package:simple_weather/config/config.dart';

class DynamicBackground extends StatelessWidget {
  const DynamicBackground({
    super.key,
    required this.weatherName,
    required this.child,
  });

  final String weatherName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    String image = imageFromWeather(weatherName);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }

  String imageFromWeather(String weatherName) {
    switch (weatherName) {
      default:
        return Assets.fieldBackground;
    }
  }
}
