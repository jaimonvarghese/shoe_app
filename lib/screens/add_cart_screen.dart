import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCartScreen extends StatelessWidget {
  const AddCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'AddScreen',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      );
  }
}