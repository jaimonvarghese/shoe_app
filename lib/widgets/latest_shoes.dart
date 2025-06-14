import 'package:flutter/material.dart';
import 'package:shoe_app/models/product_model.dart';
import 'package:shoe_app/widgets/shoe_grid_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Product>> male,
  }) : _male = male;

  final Future<List<Product>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final male = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: male.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75, // Adjust height/width ratio
            ),
            itemBuilder: (context, index) {
              final shoe = male[index];
              return ShoeGridTile(
                imageUrl: shoe.imageUrl[0],
                name: shoe.name,
                price: "\$${shoe.price}",
              );
            },
          );
        }
      },
    );
  }
}
