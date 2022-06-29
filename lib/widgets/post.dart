// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:correctin/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends StatefulWidget {
  final Map post;
  const Post({Key? key, required this.post}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PostScreen(post: widget.post);
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
                          InkWell(
                            onTap: () {},
                            child: Text(
                              widget.post['user']['firstName'] +
                                  " " +
                                  widget.post['user']['lastName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
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
                Image.asset("assets/images/dots.png"),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(widget.post['postBody']))
          ],
        ),
      ),
    );
  }
}
