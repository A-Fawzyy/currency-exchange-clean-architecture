import 'package:flutter/material.dart';

enum AppColors {
  blue(Color(0xFF4D81FF)),
  white(Color(0xFFEDEDF3)),
  black(Color(0xFF000002)),
  transparent(Colors.transparent);

  const AppColors(this.color);

  final Color color;
}
