// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../enums/profile_state.dart';

class SwitcherProfile extends StatefulWidget {
  final Function switchProfileState;
  final ProfileState profileState;

  const SwitcherProfile(
      {Key? key, required this.switchProfileState, required this.profileState})
      : super(key: key);

  @override
  State<SwitcherProfile> createState() => _SwitcherProfileState();
}

class _SwitcherProfileState extends State<SwitcherProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              widget.switchProfileState(ProfileState.posted);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: widget.profileState == ProfileState.posted
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(228, 240, 218, 1),
              ),
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Posted",
                  style: TextStyle(
                      color: widget.profileState == ProfileState.posted
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.switchProfileState(ProfileState.corrected);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: widget.profileState == ProfileState.corrected
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(228, 240, 218, 1),
              ),
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Corrected",
                  style: TextStyle(
                      color: widget.profileState == ProfileState.corrected
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
