import 'package:clutch/src/pages/IndexPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.conversation_bubble),
                title: Text('Support'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: Text('Profile'),
              ),
        ],
      ),
      tabBuilder: (BuildContext context, int index){
        assert(index >= 0 && index <= 3);
        switch(index){
          case 0:
            return CupertinoTabView(
                  builder: (BuildContext context) => IndexPage(),
                  defaultTitle: 'Inicio',
                );
                break;
          case 1:
            return CupertinoTabView(
                  builder: (BuildContext context) => IndexPage(),
                  defaultTitle: 'Page 02',
                );
                break;
          case 2:
              return CupertinoTabView(
                  builder: (BuildContext context) => IndexPage(),
                  defaultTitle: 'Page 03',
                );
                break;
          case 3:
              return CupertinoTabView(
                  builder: (BuildContext context) => IndexPage(),
                  defaultTitle: 'Page 04',
                );
                break;
        }
        return null;
      },
    );
  }
}