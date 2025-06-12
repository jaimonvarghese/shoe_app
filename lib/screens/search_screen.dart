import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'SearchScreen',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      );
  }
}