import 'package:correctin/widgets/post.dart';
import 'package:correctin/widgets/switcher.dart';
import 'package:flutter/material.dart';

import '../enums/home_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final text1 = [
    {'id': 1, 'value': 'lorem'}
  ];

  final text2 = [
    {'id': 1, 'value': 'sssss'},
    {'id': 2, 'value': 'ssfdsfdssss'},
  ];

  HomeState homeState = HomeState.teach;

  void switchHomeState(HomeState newState) {
    setState(() {
      homeState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Switcher(
        switchHomeState: switchHomeState,
        homeState: homeState,
      ),
      Post(
        text: text1,
      ),
      Post(
        text: text2,
      ),
    ]);
  }
}
