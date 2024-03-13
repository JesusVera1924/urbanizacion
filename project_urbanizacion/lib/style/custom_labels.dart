import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabels {
  static TextStyle h1 =
      GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.w400);

  static TextStyle h2 =
      GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500);

  static TextStyle h4 = GoogleFonts.roboto(fontSize: 12);

  static TextStyle h3 = const TextStyle(
      fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle hDialogs = const TextStyle(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle hDialogsBody = const TextStyle(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
}
