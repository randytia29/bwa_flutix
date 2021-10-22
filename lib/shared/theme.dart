import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 24;

const Color mainColor = Color(0xFF503E9D);
const Color accentColor1 = Color(0xFF2C1F63);
const Color accentColor2 = Color(0xFFFBD460);
const Color accentColor3 = Color(0xFFADADAD);
const Color colorSnackbar = Color(0xFFFF5C83);

TextStyle blackTextFont = GoogleFonts.raleway().copyWith(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 28.sp);
TextStyle whiteTextFont = GoogleFonts.raleway().copyWith(
    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28.sp);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);

Flushbar<dynamic> flutixSnackbar(BuildContext context, String? message) {
  return Flushbar(
    duration: const Duration(milliseconds: 1500),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: colorSnackbar,
    message: message,
  )..show(context);
}
