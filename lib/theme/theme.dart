import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getDefaultTheme() {
  return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xffBCA37F)),
      useMaterial3: true,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xff7F5539)));
}
