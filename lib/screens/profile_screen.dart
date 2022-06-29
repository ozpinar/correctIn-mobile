// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:correctin/enums/profile_state.dart';
import 'package:correctin/widgets/corrected_post.dart';
import 'package:correctin/widgets/post.dart';
import 'package:correctin/widgets/switcher_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../storage.dart';

class ProfileScreen extends StatefulWidget {
  final Map? externalUser;
  const ProfileScreen({Key? key, this.externalUser = const {}})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String followStatus = "NOTFOLLOWING";
  var followers = [];
  var following = [];
  var followerCount = 0;
  var followingCount = 0;

  ProfileState profileState = ProfileState.posted;
  void switchProfileState(ProfileState newState) {
    setState(() {
      profileState = newState;
    });
  }

  void sendFollowRequest() async {
    try {
      var response = await Dio().post(
          dotenv.env['API_URL']! +
              "/api/user/follow/${widget.externalUser!['id']}",
          options: Options(headers: {
            'authorization': "Bearer ${await storage.read(key: 'token')}"
          }));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Follow request sent!"),
          behavior: SnackBarBehavior.floating,
        ));
        setState(() {
          followStatus = "SENT";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You are already following this user!"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void withdrawRequest() async {
    try {
      var response = await Dio().put(
          dotenv.env['API_URL']! +
              "/api/user/follow/withdraw/${widget.externalUser!['id']}?type=following",
          options: Options(headers: {
            'authorization': "Bearer ${await storage.read(key: 'token')}"
          }));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Follow request has been withdrawn!"),
          behavior: SnackBarBehavior.floating,
        ));
        setState(() {
          followStatus = "NOTFOLLOWING";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You can not withdraw an unsent request!"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  var loading = false;

  var flags = {
    'English': "https://www.worldometers.info/img/flags/small/tn_us-flag.gif",
    'Spanish': "https://www.worldometers.info/img/flags/small/tn_sp-flag.gif",
    'Turkish': "https://www.worldometers.info/img/flags/small/tn_tu-flag.gif",
    'Portuguese':
        "https://www.worldometers.info/img/flags/small/tn_po-flag.gif",
    'French': "https://www.worldometers.info/img/flags/small/tn_fr-flag.gif",
    'Italian': "https://www.worldometers.info/img/flags/small/tn_it-flag.gif",
    'Polish': "https://www.worldometers.info/img/flags/small/tn_pl-flag.gif",
    'Romanian': "https://www.worldometers.info/img/flags/small/tn_ro-flag.gif"
  };

  @override
  void initState() {
    super.initState();
    getValues();
  }

  Map user = Map();
  var token = "";
  var langId = 0;
  var foreignLangId = 0;
  var posts = [];
  var checkedPosts = [];

  void getValues() async {
    setState(() {
      loading = true;
    });
    var userRes = (await storage.read(key: 'user'))!;
    var tokenRes = (await storage.read(key: 'token'))!;
    setState(() {
      mapEquals(widget.externalUser, {})
          ? user = json.decode(userRes)
          : user = widget.externalUser!;
      token = tokenRes;
      langId = user['nativeLanguage']['id'];
      foreignLangId = user['foreignLanguage']['id'];
    });

    var responsePosts = await Dio().get(
        dotenv.env['API_URL']! +
            '/api/post/all?sortBy=createdAt&orderBy=desc&userId=${user['id']}',
        options: Options(headers: {
          'authorization': "Bearer $token",
        }));
    var responseCheckedPosts = await Dio().get(
        dotenv.env['API_URL']! +
            '/api/post/checked-post/all?sortBy=createdAt&orderBy=desc&userId=${user['id']}',
        options: Options(headers: {
          'authorization': "Bearer $token",
        }));

    var responseFollowers = await Dio()
        .get("${dotenv.env['API_URL']}/api/user/follow/${user['id']}",
            options: Options(headers: {
              'authorization': "Bearer $token",
            }));

    setState(() {
      posts = responsePosts.data['posts'];
      checkedPosts = responseCheckedPosts.data['checkedPosts'];
      followers = responseFollowers.data['followers'];
      following = responseFollowers.data['followings'];
      followerCount = responseFollowers.data['followersTotalItems'];
      followingCount = responseFollowers.data['followingsTotalItems'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                )
              ]),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  scale: .5,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${user['firstName'] ?? ""} ${user['lastName'] ?? ""}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Text(
                            "Native",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              user.containsKey('nativeLanguage')
                                  ? flags[user['nativeLanguage']
                                      ['languageName']]!
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/480px-Solid_white.svg.png",
                              scale: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Text(
                            "Learning",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              user.containsKey('foreignLanguage')
                                  ? flags[user['foreignLanguage']
                                      ['languageName']]!
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/480px-Solid_white.svg.png",
                              scale: 3,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  ...followers
                                      .map((follower) => Container(
                                            padding: EdgeInsets.all(12),
                                            child: Text(
                                                "${follower['firstName']} ${follower['lastName']}"),
                                          ))
                                      .toList(),
                                ],
                              );
                            });
                      },
                      child: Text(
                        '$followerCount followers',
                        style: TextStyle(
                            color: Color.fromRGBO(89, 52, 79, 1),
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  ...following
                                      .map((follow) => Container(
                                            padding: EdgeInsets.all(12),
                                            child: Text(
                                                "${follow['firstName']} ${follow['lastName']}"),
                                          ))
                                      .toList(),
                                ],
                              );
                            });
                      },
                      child: Text(
                        '$followingCount following',
                        style: TextStyle(
                            color: Color.fromRGBO(89, 52, 79, 1),
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                mapEquals(widget.externalUser, {})
                    ? Row()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (followStatus == "NOTFOLLOWING") {
                                  sendFollowRequest();
                                } else if (followStatus == "SENT") {
                                  withdrawRequest();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(228, 240, 218, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: followStatus == "NOTFOLLOWING"
                                  ? Text(
                                      'Follow',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Withdraw",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                        ],
                      )
              ],
            ),
          ),
        ),
        loading
            ? Padding(
                padding: const EdgeInsets.all(64.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Expanded(
                child: ListView(
                  children: [
                    SwitcherProfile(
                        switchProfileState: switchProfileState,
                        profileState: profileState),
                    profileState == ProfileState.posted
                        ? Column(
                            children: [
                              ...posts.map((post) => Post(post: post)).toList()
                            ],
                          )
                        : Column(
                            children: [
                              ...checkedPosts
                                  .map((post) =>
                                      CorrectedPost(correctedPost: post))
                                  .toList()
                            ],
                          )
                  ],
                ),
              )
      ],
    );
  }
}
