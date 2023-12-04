import 'package:flutter/material.dart';

Map<String, Color> colorsFromWeather({required String weather}) {
  switch (weather) {
    case 'Clouds':
      return {
        'text': Colors.grey.shade500,
        'bg': Colors.grey.shade900,
      };
    case 'Rain':
      return {
        'text': Colors.blue.shade600.withOpacity(0.75),
        'bg': Colors.white.withOpacity(0.5),
      };
    case 'Sunny':
      return {
        'bg': Colors.orange.withOpacity(0.75),
        'text': Colors.orange.shade800,
      };
    case 'Snow':
      return {
        'bg': Colors.blue.shade100.withOpacity(0.75),
        'text': Colors.blue.shade300,
      };
    default:
      return {
        'text': Colors.grey.withOpacity(0.75),
        'bg': Colors.grey.shade600,
      };
  }
}
