
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const scaffoldBackgroundColor = Color.fromARGB(255, 30, 30, 31);

class AppTheme {

  static const taskBoxColor = Color.fromARGB(255, 14, 26, 78);
  static const taskPagesBackground = Color.fromARGB(255, 50, 68, 121);

  ThemeData getTheme() => ThemeData(
    
    //* General
    useMaterial3: true,
    brightness: Brightness.dark,
    
    //* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 35, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 22, fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 14, fontWeight: FontWeight.bold)
    ),

    //* Scaffold background color
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    //* Button color
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
        )
      )
    ),

    //* AppBar color
    appBarTheme: AppBarTheme(
      color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold )
    ),

  );
}