import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData showIcon({required String weatherName}) {
  switch (weatherName) {
    case 'Clouds':
      return CupertinoIcons.cloud_fill;
    case 'Rain':
      return CupertinoIcons.cloud_rain;
    case 'Sunny':
      return FontAwesomeIcons.sun;
    default:
      return Icons.warning;
  }
}
