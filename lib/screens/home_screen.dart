import 'package:correctin/widgets/corrected_post.dart';
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
  final text1 = {'id': 1, 'value': 'loreffdm'};

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
      homeState == HomeState.teach
          ? Post(
              id: text1['id'] as int,
              text: text1['value'] as String,
            )
          : CorrectedPost(),
    ]);
  }
}
