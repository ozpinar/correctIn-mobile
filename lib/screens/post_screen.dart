// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, type_init_formals

import 'package:correctin/screens/profile_screen.dart';
import 'package:correctin/storage.dart';
import 'package:correctin/widgets/correct.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'main_layout.dart';

class PostScreen extends StatefulWidget {
  final Map post;
  const PostScreen({Key? key, required this.post}) : super(key: key);

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

  late final correctController;
  late final commentController;
  @override
  void initState() {
    print(widget.post);
    // TODO: implement initState
    super.initState();
    setState(() {
      correctController = TextEditingController()
        ..text = widget.post['postBody'];
      commentController = TextEditingController();
    });
  }

  void correctEntry() async {
    var response =
        await Dio().post(dotenv.env['API_URL']! + '/api/post/checked-post',
            data: {
              'oldPostId': widget.post['id'],
              'postBody': correctController.text,
              'comment': commentController.text,
            },
            options: Options(headers: {
              'authorization': "Bearer ${await storage.read(key: 'token')}",
            }));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post has been corrected succesfully!"),
        behavior: SnackBarBehavior.floating,
      ));
    }
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MainLayout(
                                      page: 'profile',
                                      user: widget.post['user'],
                                    ))));
                      },
                      child: Row(
                        children: [
                          Image.asset("assets/images/profile.png"),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post['user']['firstName'] +
                                      " " +
                                      widget.post['user']['lastName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  timeago.format(
                                      DateTime.parse(widget.post['createdAt'])),
                                  style: TextStyle(
                                      color: Color.fromRGBO(83, 127, 85, 0.5)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
                                controller: correctController,
                                keyboardType: TextInputType.multiline,
                              )
                            : Text(widget.post['postBody']),
                        if (isEditing)
                          TextField(
                            controller: commentController,
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
                        if (!isEditing) {
                          correctEntry();
                        }
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
