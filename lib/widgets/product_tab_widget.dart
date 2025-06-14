import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/models/product_model.dart';
import 'package:shoe_app/providers/product_provider.dart';
import 'package:shoe_app/screens/product_by_cat.dart';
import 'package:shoe_app/widgets/new_shoes.dart';
import 'package:shoe_app/widgets/product_card.dart';
import 'package:shoe_app/widgets/product_page.dart';

class ProductTabWidget extends StatelessWidget {
  const ProductTabWidget({
    super.key,
    required this.futureList,
    required this.tabIndex,
  });
  final Future<List<Product>> futureList;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Product>>(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products available"));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      final shoe = products[index];
                      return GestureDetector(
                        onTap: () {
                          productNotifier.shoesSizes = shoe.sizes;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (ctx) => ProductPage(
                                    id: shoe.id,
                                    category: shoe.category,
                                  ),
                            ),
                          );
                        },
                        child: ProductCard(
                          price: '\$ ${shoe.price}',
                          category: shoe.category,
                          id: shoe.id,
                          name: shoe.name,
                          image: shoe.imageUrl[0],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Shoes',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Show All',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ProductByCat(tabIndex: tabIndex),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 22),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: FutureBuilder<List<Product>>(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products available"));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      final shoe = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewShoes(imageUrl: shoe.imageUrl[1]),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
