import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_app/models/product_model.dart';
import 'package:shoe_app/services/product_service.dart';
import 'package:shoe_app/widgets/product_tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // TOP IMAGE SECTION
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Athletics Shoes',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'Collections',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TabBar(
                      dividerColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'Men Shoes'),
                        Tab(text: 'Women Shoes'),
                        Tab(text: 'Kids Shoes'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // PRODUCT TABS SECTION
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.265,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProductTabWidget(futureList: _male, tabIndex: 0),
                  ProductTabWidget(futureList: _female, tabIndex: 1),
                  ProductTabWidget(futureList: _kids, tabIndex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
