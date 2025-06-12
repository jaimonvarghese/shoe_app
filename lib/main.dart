import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/bottom_nav_provider.dart';
import 'package:shoe_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BottomNavProvider())],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen()),
    );
  }
}
