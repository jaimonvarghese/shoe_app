import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_app/models/product_model.dart';
import 'package:shoe_app/services/product_service.dart';
import 'package:shoe_app/widgets/category_btn.dart';
import 'package:shoe_app/widgets/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  late Future<List<Product>> _male;
  late Future<List<Product>> _female;
  late Future<List<Product>> _kids;

  void _getData() {
    _male = ProductService().getMaleSneakers();
    _female = ProductService().getFemaleSneakers();
    _kids = ProductService().getKidsSneakers();
  }

  @override
  void initState() {
    _getData();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(Icons.menu, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    dividerColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Men Shoes"),
                      Tab(text: "Women Shoes"),
                      Tab(text: "Kids Shoes"),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(male: _male),
                    LatestShoes(male: _female),
                    LatestShoes(male: _kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.84,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        "Filter",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Gender",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          CategoryBtn(label: "Men", buttonClr: Colors.black),
                          CategoryBtn(label: "Women", buttonClr: Colors.grey),
                          CategoryBtn(label: "Kids", buttonClr: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          CategoryBtn(label: "Shoes", buttonClr: Colors.black),
                          CategoryBtn(
                            label: "Apparrels",
                            buttonClr: Colors.grey,
                          ),
                          CategoryBtn(
                            label: "Accessories",
                            buttonClr: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {},
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Brand",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 80,
                        child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
