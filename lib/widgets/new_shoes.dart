import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  const NewShoes({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 0.8,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
