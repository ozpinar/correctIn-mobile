// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:correctin/screens/finder_screen.dart';
import 'package:correctin/screens/home_screen.dart';
import 'package:correctin/screens/post_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../storage.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainLayout extends StatefulWidget {
  final String page;
  final Map user;
  const MainLayout({Key? key, this.page = "", this.user = const {}})
      : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final postController = TextEditingController();
  int currentTab = 0;
  var loading = false;
  var requests = [];
  final List<Widget> screens = [
    HomeScreen(),
    MessagesScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  void sendPost() async {
    var response = await Dio().post(dotenv.env['API_URL']! + '/api/post',
        data: {
          'postTitle': postController.text,
          'postBody': postController.text,
        },
        options: Options(headers: {
          'authorization': "Bearer ${await storage.read(key: 'token')}"
        }));

    if (response.statusCode == 200) {
      postController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post sent succesfully!"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void getFollowRequests() async {
    setState(() {
      loading = true;
    });
    var response = await Dio().get(
        dotenv.env['API_URL']! + '/api/user/follow/followers-requests',
        options: Options(headers: {
          'authorization': "Bearer ${await storage.read(key: 'token')}"
        }));
    setState(() {
      loading = false;
      requests = response.data['followerRequests'];
    });
  }

  void acceptRequest(id) async {
    var response =
        await Dio().put('${dotenv.env['API_URL']!}/api/user/follow/accept/$id',
            data: {},
            options: Options(headers: {
              'authorization': "Bearer ${await storage.read(key: 'token')}",
            }));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Follow request has been accepted!"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void rejectRequest() async {}

  @override
  void initState() {
    if (widget.page == 'profile') {
      setState(() {
        currentScreen = ProfileScreen(
          externalUser: widget.user,
        );
        currentTab = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              getFollowRequests();
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "Follow Requests",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: requests.isEmpty
                                ? Text("There are no follow requests!")
                                : ListView(children: [
                                    ...requests.map((request) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${request['firstName']} ${request['lastName']}"),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    acceptRequest(
                                                        request['id']);
                                                  },
                                                  icon: Icon(Icons.check),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.close),
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          ],
                                        ))
                                  ]),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
        elevation: 0.8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Correct",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "In",
              style: TextStyle(
                color: Color.fromRGBO(146, 188, 148, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2.25,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            controller: postController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: "What do you think?"),
                          ),
                          Container(
                            margin: EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    sendPost();
                                  },
                                  child: Text("POST"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          )
                        ]),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = FinderScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: currentTab == 1
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Finder",
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          )
                        ]),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: currentTab == 2
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                color: currentTab == 2
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          )
                        ]),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingsScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                                color: currentTab == 3
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          )
                        ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
