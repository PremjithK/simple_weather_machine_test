import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData showWeatherIcon({required String name}) {
  switch (name) {
    case 'Clouds':
      return CupertinoIcons.cloud;
    case 'Rain':
      return CupertinoIcons.cloud_rain;
    case 'Sunny':
      return FontAwesomeIcons.sun;
    case 'Snow':
      return CupertinoIcons.cloud_snow;
    default:
      return Icons.warning;
  }
}
