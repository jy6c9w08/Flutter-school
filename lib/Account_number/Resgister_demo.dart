import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './Login_demo.dart';

String registerUrl="http://121.41.123.231:5000/user/register";

class RegisterPageWidget extends StatefulWidget {
  @override
  RegisterPageWidgetState createState() => RegisterPageWidgetState();
}

class RegisterPageWidgetState extends State<RegisterPageWidget> {
int userId;
String password;
String username;
final registerFormKey=GlobalKey<FormState>();

void register()  async {

  Dio dio=Dio();
  var result=await dio.post(registerUrl,data:{
    "user_id":userId,
    "username":username,
    "password":password,
  });
  print(result);
  print(result.statusCode);
  if(result.statusCode==200){
   Navigator.pop(context);
  }
}


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: registerFormKey,
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
                  hintText: "你的注册账号",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
//                controller: usernameController,
//当 Form 表单调用保存方法 Save时回调的函数。
                onSaved: (value) {
                  userId = int.parse(value);
                },
// 当用户确定已经完成编辑时触发
                // onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 30.0),

              TextFormField(
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: "你的用户名",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
//                controller: usernameController,
//当 Form 表单调用保存方法 Save时回调的函数。
                onSaved: (value) {
                  username = value;
                },
// 当用户确定已经完成编辑时触发
                // onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '请输入密码',
                  hintText: '你的注册密码',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
//是否是密码
//                    obscureText: true,
//                controller: passwordController,
                onSaved: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 60.0),
              SizedBox(
                height: 45.0,
                width: 270.0,
                child: RaisedButton(
                  shape: StadiumBorder(side: BorderSide()),
                  child: Text(
                    "注册",
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    registerFormKey.currentState.save();
                    register();
                    Fluttertoast.showToast(
                        toastLength:Toast.LENGTH_LONG ,
                        timeInSecForIosWeb: 2,
                        msg: "注册中......",
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 14);
                  },
                ),
              ),
              SizedBox(height: 30.0),
//              Padding(
//                padding: EdgeInsets.only(top: 10.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text("没有账号？"),
//                    GestureDetector(
//                      child: Text(
//                        "点击注册",
//                        style: TextStyle(color: Colors.green),
//                      ),
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => RegisterPageWidget()),
//                        );
//                      },
//                    )
//                  ],
//                ),
//              )
            ],
          )),
    );
  }
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
      'Register',
      style: TextStyle(fontSize: 42.0),
    ),
  );
}

