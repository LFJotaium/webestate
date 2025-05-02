import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(Locale locale) {

  if (locale.languageCode == 'he') {
    return ThemeData(

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue, // Primary base color (blue)
        brightness: Brightness.light, // Or .dark for dark mode
      ),      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.notoSerifHebrew(), // Hebrew font
      ),
    );
  } else if (locale.languageCode == 'ar') {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue, // Primary base color (blue)
        brightness: Brightness.light, // Or .dark for dark mode
      ),      primarySwatch: Colors.green,
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.cairo(), // Arabic font
      ),
    );
  }
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue, // Primary base color (blue)
      brightness: Brightness.light, // Or .dark for dark mode
    ),    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.cairo(), // Default font
    ),
  );
}
