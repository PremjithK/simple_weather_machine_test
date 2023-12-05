import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData showWeatherIcon({required String name}) {
  switch (name.toUpperCase()) {
    case 'CLOUDS':
      return CupertinoIcons.cloud;
    case 'RAIN':
      return CupertinoIcons.cloud_rain;
    case 'SUNNY':
      return FontAwesomeIcons.sun;
    case 'CLEAR':
      return CupertinoIcons.cloud_sun;
    case 'SNOW':
      return CupertinoIcons.cloud_snow;
    default:
      return Icons.warning;
  }
}
