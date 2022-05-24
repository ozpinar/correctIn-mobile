// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final List text;
  const PostScreen({Key? key, required List this.text}) : super(key: key);

  @override
  State<PostScreen> createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  List selectedWords = [];
  void toggleWord(word) {
    if (selectedWords.contains(word)) {
      setState(() {
        selectedWords.remove(word);
      });
      return;
    }
    setState(() {
      selectedWords.add(word);
    });
  }

  bool hasWord(word) {
    return selectedWords.contains(word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        foregroundColor: Theme.of(context).primaryColor,
        title: Text("Post"),
        backgroundColor: Colors.white,
      ),
      body: Container(
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
              margin: EdgeInsets.only(top: 15),
              child: Wrap(
                children: [
                  ...widget.text
                      .map((word) => InkWell(
                            onTap: () {
                              toggleWord(word);
                            },
                            child: Text(
                              word['value'] + ' ',
                              style: TextStyle(
                                  backgroundColor:
                                      hasWord(word) ? Colors.green : null,
                                  color: hasWord(word)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18),
                            ),
                          ))
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
