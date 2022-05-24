import 'package:correctin/screens/home_screen.dart';
import 'package:correctin/screens/post_screen.dart';
import 'package:flutter/material.dart';

import 'messages_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    MessagesScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () {},
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
                        currentScreen = MessagesScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: currentTab == 1
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Messages",
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
