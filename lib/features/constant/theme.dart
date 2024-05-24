import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getDefaultTheme() {
  return ThemeData(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff7F5539)),
      useMaterial3: true,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xff7F5539)));
}
