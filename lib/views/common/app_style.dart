import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.roboto(fontSize: size, color: color, fontWeight: fw);
}

TextStyle roundFont(double size, Color color, FontWeight fw) {
  return GoogleFonts.varelaRound(fontSize: size, color: color, fontWeight: fw);
}
