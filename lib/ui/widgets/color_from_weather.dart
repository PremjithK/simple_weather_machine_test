import 'package:flutter/material.dart';

Map<String, Color> colorsFromWeather({required String weather}) {
  switch (weather.toUpperCase()) {
    case 'CLOUDS':
      return {
        'bg': Colors.grey.shade700,
        'text': Colors.grey.shade500,
      };
    case 'RAIN':
      return {
        'text': Colors.white,
        'bg': const Color.fromARGB(255, 35, 61, 92),
      };
    case 'SUNNY':
      return {
        'bg': const Color.fromARGB(255, 69, 35, 23),
        'text': Colors.brown.shade600,
      };
    case 'SNOW':
      return {
        'bg': const Color.fromARGB(255, 72, 87, 100),
        'text': const Color.fromARGB(255, 74, 94, 111),
      };
    case 'CLEAR':
      return {
        'bg': const Color.fromARGB(255, 21, 30, 39),
        'text': const Color.fromARGB(255, 28, 45, 60),
      };
    default:
      return {
        'text': Colors.black,
        'bg': Colors.black,
      };
  }
}
