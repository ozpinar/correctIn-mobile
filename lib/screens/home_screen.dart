// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:correctin/storage.dart';
import 'package:correctin/widgets/corrected_post.dart';
import 'package:correctin/widgets/post.dart';
import 'package:correctin/widgets/switcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../enums/home_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final text1 = {'id': 1, 'value': 'loreffdm'};

  HomeState homeState = HomeState.teach;
  Map<dynamic, dynamic> user = Map();
  Object token = "";
  var langId = 0;
  var foreignLangId = 0;
  var posts = [];
  var correctedPosts = [];
  var loading = false;

  void switchHomeState(HomeState newState) {
    setState(() {
      homeState = newState;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  void getPosts() async {
    setState(() {
      loading = true;
    });
    var userRes = (await storage.read(key: 'user'))!;
    var tokenRes = (await storage.read(key: 'token'))!;
    setState(() {
      user = json.decode(userRes);
      token = tokenRes;
      langId = user['nativeLanguage']['id'];
      foreignLangId = user['foreignLanguage']['id'];
    });

    var responsePosts = await Dio().get(
        dotenv.env['API_URL']! +
            '/api/post/all?sortBy=createdAt&size=100&orderBy=desc&foreignLanguageId=${langId}&isChecked=false',
        options: Options(headers: {
          'authorization': "Bearer $token",
        }));
    var responseCheckedPosts = await Dio().get(
        dotenv.env['API_URL']! +
            '/api/post/checked-post/all?sortBy=createdAt&orderBy=desc&nativeLanguageId=${foreignLangId}',
        options: Options(headers: {
          'authorization': "Bearer $token",
        }));
    setState(() {
      posts = responsePosts.data['posts'];
      correctedPosts = responseCheckedPosts.data['checkedPosts'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : ListView(children: [
            Switcher(
              switchHomeState: switchHomeState,
              homeState: homeState,
            ),
            homeState == HomeState.teach
                ? posts.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "There are no posts to show.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          ...posts
                              .map((post) => Post(
                                    post: post,
                                  ))
                              .toList()
                        ],
                      )
                : correctedPosts.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "There are no posts to show.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          ...correctedPosts
                              .map((post) => CorrectedPost(
                                    correctedPost: post,
                                  ))
                              .toList()
                        ],
                      )
          ]);
  }
}
