import 'dart:convert';

import 'package:correctin/screens/login_screen.dart';
import 'package:correctin/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map user = Map();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  void getValues() async {
    var userRes = await storage.read(key: 'user');
    setState(() {
      user = json.decode(userRes!);
    });
  }

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'English';

    // List of items in our dropdown menu
    var items = [
      'English',
      'Portuguese',
      'Spanish',
      'French',
      'Italian',
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
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
                    "Update Information",
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      children: const [Text('Full Name')],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: TextEditingController(
                              text: "${user['firstName']} ${user['lastName']}"),
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
                          controller:
                              TextEditingController(text: user['email']),
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
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: const [Text('Native')],
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: const [Text('Target')],
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await storage.deleteAll();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
