import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Account_number/Login_demo.dart';
import '../Buttom/Bottom_demo.dart';

class StartApp extends StatefulWidget {
  StartApp({Key key}) : super(key: key);

  _StartAppState createState() => _StartAppState();
}


class _StartAppState extends State<StartApp>{

    var loginState;

    void initState(){
        super.initState();
        _validateLogin();
    }
    
    @override
    Widget build(BuildContext context){
        ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);

        // final router = Router();
        // Routes.configureRoutes(router);
        // Application.router = router;

        print(loginState);
        if(loginState == 0){
            return LoginPageWidget();
        }else{
            return BottomNavigationBarDemo();
        }
    }

    Future _validateLogin() async{
            Future<dynamic> future = Future(()async{
                SharedPreferences prefs =await SharedPreferences.getInstance();
                return prefs.getString("account");
            });
            future.then((val){
                if(val == null){
                    setState(() {
                        loginState = 0;
                    });
                }else{
                    setState(() {
                        loginState = 1;
                    });
                }
            }).catchError((_){
                print("catchError");
            });
        
    }

}

