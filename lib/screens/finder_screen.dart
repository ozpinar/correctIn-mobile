// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:correctin/screens/main_layout.dart';
import 'package:correctin/screens/profile_screen.dart';
import 'package:correctin/storage.dart';
import 'package:correctin/widgets/chat_person.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinderScreen extends StatefulWidget {
  const FinderScreen({Key? key}) : super(key: key);

  @override
  State<FinderScreen> createState() => _FinderScreenState();
}

class _FinderScreenState extends State<FinderScreen> {
  final searchController = TextEditingController();
  var results = [];
  var loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void searchUser(query) async {
    setState(() {
      loading = true;
    });
    var response = await Dio().get(
        dotenv.env['API_URL']! + '/api/user?s=' + query,
        options: Options(headers: {
          'authorization': 'Bearer ${await storage.read(key: 'token')}'
        }));
    setState(() {
      results = response.data['users'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: TextField(
            onChanged: (_) {
              if (searchController.text.length < 2) {
                setState(() {
                  results = [];
                });
                return;
              }
              searchUser(searchController.text);
            },
            controller: searchController,
            decoration: InputDecoration(
                hintText: "Search sommeone...",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
            : Column(
                children: [
                  ...results
                      .map((res) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => MainLayout(
                                                page: 'profile',
                                                user: res,
                                              ))));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 350,
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      res['firstName'] + " " + res['lastName'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromRGBO(92, 134, 93, .2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ],
              )
      ],
    );
  }
}
