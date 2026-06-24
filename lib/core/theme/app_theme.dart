import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/theme/app_pallete.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /*static ThemeData light() {
    final palette = Palettes.light;
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(primary: palette.primaryTextColor!),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(bodyColor: palette.primaryTextColor),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
      extensions: [palette],
      iconTheme: IconThemeData(color: palette.primaryTextColor),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.snackbarBackgroundColor,
        contentTextStyle: TextStyle(color: palette.snackbarTextColor),
      ),
    );
  }

  static ThemeData dark() {
    final palette = Palettes.dark;
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(),
      colorScheme: ColorScheme.dark().copyWith(primary: Colors.white),
      extensions: [palette],
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.snackbarBackgroundColor,
        contentTextStyle: TextStyle(color: palette.snackbarTextColor),
      ),
    );
  }*/

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.black,
      surface: Colors.white,
      //onSurface: Colors.red,
    ),
  );
}
