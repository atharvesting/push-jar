import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Reusable AppBar
PreferredSizeWidget buildAppTopBar() {
  return AppBar(
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: SvgPicture.asset('assets/icons/3LC.svg', fit: BoxFit.contain),
        ),
        const SizedBox(width: 6),
        Text(
          "Push Jar!",
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    ),
    actions: [
      Text(
        "V0.1\nAll rights reserved",
        textAlign: TextAlign.right,
        style: GoogleFonts.playfairDisplay(fontSize: 11),
      ),
      const SizedBox(width: 20),
    ],
  );
}