import 'package:flutter/material.dart';

Map<String, Color> colorsFromWeather({required String weather}) {
  switch (weather) {
    case 'Clouds':
      return {
        'text': Color.fromARGB(255, 98, 75, 66),
        'bg': const Color.fromARGB(255, 162, 142, 135),
      };
    case 'Rain':
      return {
        'text': Color.fromARGB(255, 42, 70, 109),
        'bg': Color.fromARGB(255, 86, 109, 144),
      };
    case 'Sunny':
      return {
        'bg': Colors.orange.shade300,
        'text': Colors.orange.shade700,
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
