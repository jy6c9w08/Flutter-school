import 'package:flutter/material.dart';
import 'package:flutter_tujin/Page/My_demo.dart';
import 'package:flutter_tujin/Page/postPage.dart';
import 'Page/Home_demo.dart';
import './Page/Graduation_demo.dart';
import './Buttom/Bottom_demo.dart';
import './Page/My_demo.dart';
import './Page/School_enrollment_demo.dart';
import './Details_Page/Person_demo.dart';
import './Account_number/Login_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Page/Start_demo.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
 Future _readShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String account = preferences.get('account');
     print('读取到acount为:$account');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.blue,
      ),
      title: "校园云邦",
      initialRoute:  '/postPage',
      routes: {
        '/start':(context)=>StartApp(),
        '/buttomnavitor': (context) => BottomNavigationBarDemo(),
        '/': (context) => Home_Page(),
        '/graduation': (context) => Graduation_Page(),
        '/my': (context) => My_Page(),
        '/school_enrollment': (context) => School_enrollment_Page(),
        '/person': (context) => Person_Page(),
        '/loginPageWidget': (context) => LoginPageWidget(),
        '/postPage':(context)=>postPage()
      },
    );
  }
}
