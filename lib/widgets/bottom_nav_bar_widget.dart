import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/bottom_nav_provider.dart';
import 'package:shoe_app/widgets/bottom_nav_item_widget.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Consumer<BottomNavProvider>(
            builder: (context, bottomNavProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItemWidget(
                    icon: Icons.home_filled,

                    onTap: () => bottomNavProvider.pageIndex = 0,
                    color:
                        bottomNavProvider.pageIndex == 0
                            ? Colors.white
                            : Colors.grey,
                  ),
                  BottomNavItemWidget(
                    icon: Icons.search,
                    onTap: () => bottomNavProvider.pageIndex = 1,
                    color:
                        bottomNavProvider.pageIndex == 1
                            ? Colors.white
                            : Colors.grey,
                  ),
                  BottomNavItemWidget(
                    icon: Icons.add_circle,
                    onTap: () => bottomNavProvider.pageIndex = 2,
                    color:
                        bottomNavProvider.pageIndex == 2
                            ? Colors.white
                            : Colors.grey,
                  ),
                  BottomNavItemWidget(
                    icon: Icons.shopping_bag,
                    onTap: () => bottomNavProvider.pageIndex = 3,
                    color:
                        bottomNavProvider.pageIndex == 3
                            ? Colors.white
                            : Colors.grey,
                  ),
                  BottomNavItemWidget(
                    icon: Icons.account_circle,
                    onTap: () => bottomNavProvider.pageIndex = 4,
                    color:
                        bottomNavProvider.pageIndex == 4
                            ? Colors.white
                            : Colors.grey,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
