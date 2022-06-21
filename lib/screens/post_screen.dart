// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, type_init_formals

import 'package:correctin/widgets/correct.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final String text;
  final int id;
  const PostScreen({Key? key, required String this.text, required this.id})
      : super(key: key);

  @override
  State<PostScreen> createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  var isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
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
      body: Column(
        children: [
          Container(
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
                    margin: EdgeInsets.only(top: 15, bottom: 25),
                    child: Column(
                      children: [
                        isEditing
                            ? TextField(
                                controller: TextEditingController()
                                  ..text = widget.text,
                                onChanged: (text) => {},
                                keyboardType: TextInputType.multiline,
                              )
                            : Text(widget.text),
                        if (isEditing)
                          TextField(
                            keyboardType: TextInputType.multiline,
                            decoration:
                                InputDecoration(hintText: "Write a comment..."),
                          ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    ElevatedButton(
                      onPressed: () {
                        toggleEditing();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)))),
                      child: Text("Correct Now"),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
