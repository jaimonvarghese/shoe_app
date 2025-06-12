import 'package:flutter/material.dart';

class BottomNavItemWidget extends StatelessWidget {
  const BottomNavItemWidget({
    super.key,
    required this.icon,
    required this.onTap, required this.color,
  });
  final IconData icon;
  final Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Icon(icon, color: color),
      ),
    );
  }
}