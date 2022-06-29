// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:correctin/screens/main_layout.dart';
import 'package:correctin/screens/signup_screen.dart';
import 'package:correctin/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var loading = false;

  void login() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await Dio()
          .post(dotenv.env['API_URL']! + '/api/auth/login', data: {
        'email': emailController.text,
        'password': passwordController.text
      });
      await storage.write(key: 'token', value: response.data['jwt-token']);
      await storage.write(
          key: 'user', value: jsonEncode(response.data['user']));
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainLayout()));
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Correct",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "In",
              style: TextStyle(
                color: Color.fromRGBO(146, 188, 148, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 100),
        margin: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login ",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "Correct",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const Text(
                      "In",
                      style: TextStyle(
                          color: Color.fromRGBO(146, 188, 148, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Login to start learning",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: const [Text('E-mail address')],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: const [Text('Password')],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: loading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              ),
                            )
                          : Text('Login'),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text("Don't have an account?"),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text("Sign Up")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
