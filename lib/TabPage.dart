import 'package:flutter/material.dart';
import 'package:flutter_app/pages/mine_page.dart';
import 'package:flutter_app/pages/search_page.dart';


class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  //界面数组
  List<Widget> pages = [
    MinePage(),
    SearchPage()
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              _currentIndex = index;
              setState(() {});
            },
            selectedFontSize: 12.0,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.blue,
            currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('我的')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('搜索')
              ),
            ]
        ),
        body: pages[_currentIndex],
      ),
    );
  }
}