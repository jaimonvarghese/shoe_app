import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'ProfileScreen',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      );
  }
}