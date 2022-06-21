import 'package:correctin/screens/main_layout.dart';
import 'package:correctin/screens/signup_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        children: const [
                          Expanded(
                              child: TextField(
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
                        children: const [
                          Expanded(
                              child: TextField(
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
                      onPressed: () {},
                      child: Text('Login'),
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
