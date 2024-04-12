
import 'package:flutter/material.dart';

import '../../constants/freshpress_color.dart';


class FreshPressTextThemes {
  FreshPressTextThemes._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: FreshPressColors.darkBg)
  );
  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: FreshPressColors.darkBg)
  );
}