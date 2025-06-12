import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/bottom_nav_provider.dart';
import 'package:shoe_app/screens/add_cart_screen.dart';
import 'package:shoe_app/screens/cart_list_screen.dart';
import 'package:shoe_app/screens/home_screen.dart';
import 'package:shoe_app/screens/profile_screen.dart';
import 'package:shoe_app/screens/search_screen.dart';
import 'package:shoe_app/widgets/bottom_nav_bar_widget.dart';
import 'package:shoe_app/widgets/bottom_nav_item_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    HomeScreen(),
    SearchScreen(),
    AddCartScreen(),
    CartListScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavBarWidget(),
          body: pageList[bottomNavProvider.pageIndex],
        );
      },
    );
  }
}


