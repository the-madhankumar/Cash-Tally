import 'package:cash_tally/Data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget selectButton({
  required BuildContext context,
  required String data,
  required Color backgroundColor,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.30,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: AppColors.textWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          data,
          style: GoogleFonts.judson(fontSize: 32, color: AppColors.textWhite),
        ),
      ),
    ),
  );
}
