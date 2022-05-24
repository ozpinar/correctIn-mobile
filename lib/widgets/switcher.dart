// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../enums/home_state.dart';

class Switcher extends StatefulWidget {
  final Function switchHomeState;
  final HomeState homeState;

  const Switcher(
      {Key? key, required this.switchHomeState, required this.homeState})
      : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              widget.switchHomeState(HomeState.teach);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: widget.homeState == HomeState.teach
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(228, 240, 218, 1),
              ),
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Teach",
                  style: TextStyle(
                      color: widget.homeState == HomeState.teach
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.switchHomeState(HomeState.learn);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: widget.homeState == HomeState.learn
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(228, 240, 218, 1),
              ),
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Learn",
                  style: TextStyle(
                      color: widget.homeState == HomeState.learn
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
