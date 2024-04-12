
import 'package:flutter/material.dart';
import 'package:freshpress_customer/common/util/theme/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/freshpress_color.dart';


class FreshPressCustomThemes {
  FreshPressCustomThemes._();

  static ThemeData lightTheme = ThemeData(
    // textTheme: GoogleFonts.arimoTextTheme(Theme.of(context).textTheme),
    fontFamily: "Poppins",
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: FreshPressColors.darkBlue,
    scaffoldBackgroundColor:  FreshPressColors.lightGrey,
    textTheme: FreshPressTextThemes.lightTextTheme
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: FreshPressColors.lightGrey,
      scaffoldBackgroundColor:  FreshPressColors.darkBg,
      textTheme: FreshPressTextThemes.darkTextTheme
  );
}