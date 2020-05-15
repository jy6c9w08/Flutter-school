import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tujin/Buttom/Bottom_demo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Resgister_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

String loginUrl="http://121.41.123.231:5000/user/login";
class LoginPageWidget extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  //全局 Key 用来获取 Form 表单组件
final loginFormKey=GlobalKey<FormState>();
  static int _username; //用户名
  static String _password;
  DateTime _lastPressedAt;

void login()  async {

    Dio dio=Dio();
  var result=await dio.post(loginUrl,data:{
    "user_id":_username,
    "password":_password,
  });
  print(result);
  print(result.statusCode);
  if(result.statusCode==200){
    _onClick(result);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationBarDemo()),
    );
  }
  }

  @override
  void initState() {
    super.initState();
  }

  Future _onClick(var result) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('account', result.toString());
    print('存储account为:$result');
  }




  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: loginFormKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  buildTitle(),
                  buildTitleLine(),
                  SizedBox(height: 70.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '账号',
                      hintText: "123",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: usernameController,
//当 Form 表单调用保存方法 Save时回调的函数。
                    onSaved: (value) {
                      _username = int.parse(value);
                    },
// 当用户确定已经完成编辑时触发
                    // onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '请输入密码',
                      hintText: '你的登录密码',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
//是否是密码
//                    obscureText: true,
                    controller: passwordController,
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 60.0),
                  SizedBox(
                    height: 45.0,
                    width: 270.0,
                    child: RaisedButton(
                      shape: StadiumBorder(side: BorderSide()),
                      child: Text(
                        "登录",
                        style: Theme.of(context).primaryTextTheme.headline,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        loginFormKey.currentState.save();
                        login();
                        Fluttertoast.showToast(
                          toastLength:Toast.LENGTH_LONG ,
                          timeInSecForIosWeb: 2,
                            msg: "登录中......",
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 14);
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("没有账号？"),
                        GestureDetector(
                          child: Text(
                            "点击注册",
                            style: TextStyle(color: Colors.green),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPageWidget()),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        // ignore: missing_return
        onWillPop: () async {
          if (_lastPressedAt == null ||
              (DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1))) {
            _lastPressedAt = DateTime.now();
            Fluttertoast.showToast(msg: "再次点击退出程序", fontSize: 14);
            print(_lastPressedAt);
            return false;
          } else {
            SystemNavigator.pop();
          }
        });
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
