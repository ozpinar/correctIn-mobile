// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:correctin/screens/post_screen.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final List text;
  const Post({Key? key, required List this.text}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List selectedWords = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PostScreen(text: widget.text);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/profile.png"),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emiliano Espana",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "16 mins ago",
                            style: TextStyle(
                                color: Color.fromRGBO(83, 127, 85, 0.5)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/images/dots.png"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Wrap(
                children: [
                  ...widget.text
                      .map(
                        (word) => Text(
                          word['value'] + ' ',
                        ),
                      )
                      .toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
