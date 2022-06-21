// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:correctin/enums/profile_state.dart';
import 'package:correctin/widgets/corrected_post.dart';
import 'package:correctin/widgets/switcher_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileState profileState = ProfileState.posted;
  void switchProfileState(ProfileState newState) {
    setState(() {
      profileState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 20),
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
                      "John Doe",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.chat,
                      color: Theme.of(context).primaryColor,
                    )
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
                              'https://www.worldometers.info/img/flags/small/tn_tu-flag.gif',
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
                              'https://www.worldometers.info/img/flags/small/tn_fr-flag.gif',
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
                    Text(
                      '16 followers',
                      style: TextStyle(
                          color: Color.fromRGBO(89, 52, 79, 1),
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '12 following',
                      style: TextStyle(
                          color: Color.fromRGBO(89, 52, 79, 1),
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(228, 240, 218, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          'Follow',
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
        Expanded(
          child: ListView(
            children: [
              SwitcherProfile(
                  switchProfileState: switchProfileState,
                  profileState: profileState),
              CorrectedPost(),
              CorrectedPost(),
              CorrectedPost(),
            ],
          ),
        )
      ],
    );
  }
}
