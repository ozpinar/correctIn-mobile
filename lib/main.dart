import 'package:correctin/screens/home_screen.dart';
import 'package:correctin/screens/login_screen.dart';
import 'package:correctin/screens/main_layout.dart';
import 'package:correctin/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");
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
      home: LoginScreen(),
      routes: {
        '/home': (ctx) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
