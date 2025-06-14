import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/models/product_model.dart';
import 'package:shoe_app/providers/product_provider.dart';
import 'package:shoe_app/services/product_service.dart';
import 'package:shoe_app/widgets/checkout_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');

  late Future<Product> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = ProductService().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = ProductService().getFemaleSneakersById(widget.id);
    } else {
      _sneaker = ProductService().getKidsSneakersById(widget.id);
    }
  }

  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Product>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductProvider>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productNotifier.shoeSizes.clear();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Icon(
                                Icons.menu_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Image.network(
                                          sneaker.imageUrl[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                            0.1,
                                        right: 15,
                                        child: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                  ),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    productNotifier
                                                                .activepage !=
                                                            index
                                                        ? Colors.grey
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 40,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 1,
                                                  ),
                                              itemBuilder:
                                                  (context, _) => const Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: Colors.black,
                                                  ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 26,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select sizes",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  "View size guide",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    productNotifier
                                                        .shoeSizes
                                                        .length,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  final sizeItem =
                                                      productNotifier
                                                          .shoeSizes[index];
                                                  final size =
                                                      sizeItem['size']
                                                          .toString();

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                        ),
                                                    child: ChoiceChip(
                                                      label: Text(
                                                        size,
                                                        style: TextStyle(
                                                          color:
                                                              sizeItem['isSelected']
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      selected:
                                                          sizeItem['isSelected'],
                                                      selectedColor:
                                                          Colors.black,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              60,
                                                            ),
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      onSelected: (_) {
                                                        productNotifier
                                                            .toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.8,
                                          child: Text(
                                            sneaker.title,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              fontSize: 26,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          sneaker.description,
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                            ),
                                            child: CheckoutButton(
                                              onTap: () async {
                                                _createCart({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "sizes":
                                                      productNotifier.sizes[0],
                                                  "imageUrl":
                                                      sneaker.imageUrl[0],
                                                  "price": sneaker.price,
                                                  "qty": 1,
                                                });
                                                print(sneaker.name);
                                                productNotifier.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                              label: "Add to Cart",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
