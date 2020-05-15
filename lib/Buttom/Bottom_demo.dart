import 'package:flutter/material.dart';
import '../Page/School_enrollment_demo.dart';
import '../Page/Home_demo.dart';
import '../Page/My_demo.dart';
import '../Page/Graduation_demo.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomNavigationBarDemoState();
  }
}

class _BottomNavigationBarDemoState extends State<BottomNavigationBarDemo> {
  int _currentIndex = 0;
  DateTime _lastPressedAt; //上次点击的时间
  List<Widget> _pageList = [
    Home_Page(),
    Graduation_Page(),
    School_enrollment_Page(),
    My_Page(),
  ];

  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTapHandler,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('主页'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              title: Text('校友'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('招聘'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('个人'),
            ),
          ],
        ),
      ),
   onWillPop: () async {
        if (_lastPressedAt == null ||
            (DateTime.now().difference(_lastPressedAt) >
                Duration(seconds: 1))) {
          _lastPressedAt = DateTime.now();
          Fluttertoast.showToast(
              msg: "再次点击退出程序", fontSize: 14);
          print(_lastPressedAt);
          return false;
        } else {
          SystemNavigator.pop();
        }
      },
    );
  }
}
