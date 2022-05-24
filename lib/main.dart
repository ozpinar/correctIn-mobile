import 'package:correctin/screens/home_screen.dart';
import 'package:correctin/screens/main_layout.dart';
import 'package:correctin/screens/post_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(85, 127, 85, 1),
        fontFamily: 'Outfit',
      ),
      home: MainLayout(),
      routes: {
        '/home': (ctx) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
