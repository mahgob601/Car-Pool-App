import 'package:flutter/material.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedFont.dart';


SnackBar snack(String content, int duration, Color color) {
  return SnackBar(
    backgroundColor: color,
    duration: Duration(seconds: duration),
    content: Text(content, style: SharedFont.whiteStyle),
  );
}