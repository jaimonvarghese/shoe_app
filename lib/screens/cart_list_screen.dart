import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'Cart List Screen',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      );
  }
}