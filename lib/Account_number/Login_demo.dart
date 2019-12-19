import 'package:flutter/material.dart';
import 'package:apifm/apifm.dart' as Apifm;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Resgister_demo.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';

import '../Buttom/Bottom_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWidget extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  //全局 Key 用来获取 Form 表单组件

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  static String _username = ""; //用户名
  static String _password = "";
  DateTime _lastPressedAt;
  // var graphValidateCodeMap;
  void regist() async {
    var loginForm = loginKey.currentState;
    //验证 Form表单
    if (!loginForm.validate()) {
      Fluttertoast.showToast(
          msg: "请认真填写表单", gravity: ToastGravity.CENTER, fontSize: 14);
      return;
    }
    loginForm.save();
    if (_username == null || _username.trim().length < 11) {
      Fluttertoast.showToast(
          msg: "请输入手机号码", gravity: ToastGravity.CENTER, fontSize: 14);
      return;
    }
    if (_password == null || _password.trim().length < 4) {
      Fluttertoast.showToast(
          msg: "请输入登录密码", gravity: ToastGravity.CENTER, fontSize: 14);
      return;
    }
    // 读取手机信息
    String deviceId, deviceName;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      deviceName = iosInfo.name;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      deviceName = androidInfo.display;
    }
    print('deviceId: $deviceId, deviceName: $deviceName');
    var res =
        await Apifm.login_mobile(_username, _password, deviceId, deviceName);

    if (res['code'] == 0) {
      // print("打印密码$_username");
      _onClick(Textusername);
      _onClick(Textpassword);
      Fluttertoast.showToast(
          msg: "登录成功!", gravity: ToastGravity.CENTER, fontSize: 14);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationBarDemo()),
      );
    } else {
      Fluttertoast.showToast(
          msg: res['msg'], gravity: ToastGravity.CENTER, fontSize: 14);
    }
  }

  @override
  void initState() {
    Apifm.init('gooking');
    fun();

    super.initState();
  }

  Future _onClick(var Text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String account = Text.text;
    preferences.setString('account', account);
    print('存储account为:$account');
  }

  Future _readShared(var Text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String account = preferences.get('account');
    print('读取到acount为:$account');
    Text.text = account;
  }

  fun() {
    if ('account'.isNotEmpty) {
      _readShared(Textusername);
      _readShared(Textpassword);
    } else {
      return null;
    }
  }

  TextEditingController Textusername = TextEditingController();
  TextEditingController Textpassword = TextEditingController();
  // if (Textusername!=null&&Textpassword!=null) {
  //       Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => BottomNavigationBarDemo()),
  //     );
  //   } else {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
              key: loginKey,
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
                      labelText: '输入手机号',
                      hintText: "用于接收短信验证码",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    // controller: Textmbiolcontroller,
                    controller: Textusername,
//当 Form 表单调用保存方法 Save时回调的函数。
                    onSaved: (value) {
                      _username = value;
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
                    obscureText: true,
                    // controller: TextpasswordController,
                    controller: Textpassword,
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
                        regist();
                        Fluttertoast.showToast(
                          toastLength:Toast.LENGTH_LONG ,
                          timeInSecForIos: 2,
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
