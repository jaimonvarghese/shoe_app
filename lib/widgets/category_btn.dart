import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    this.onPress,
    required this.buttonClr,
    required this.label,
  });
  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: buttonClr,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
