import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'HomeScreen',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      );
  }
}