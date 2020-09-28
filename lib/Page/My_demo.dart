import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tujin/Page/postPage.dart';
import 'package:flutter_tujin/Page/post_company_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Account_number/Login_demo.dart';
import '../Page/Collection_demo.dart';
//class My_Page extends StatelessWidget {
// My_Page({Key key}) : super(key: key);

var msg;
//}
class My_Page extends StatefulWidget {
  @override
  _My_PageState createState() => _My_PageState();
}

class _My_PageState extends State<My_Page> {

  Future getAccount ()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    msg= prefs.getString("account");

   setState(() {
     msg=jsonDecode(msg);
   });


  }
  @override
  void initState() {
    getAccount();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white24,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("我的信息"),
      ),
      body: SingleChildScrollView(
       child:
          Column(
            children: <Widget>[
              TopView(),
              Container(
                height: 10,
                color: Colors.white,
              ),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text("用户名"),
                  trailing: msg==null?Text("default"):Text(msg["username"])
              ),
              ListTile(
                  leading: Icon(Icons.mode_edit),
                  title: Text("账号"),
                  trailing: msg==null?Text("default"):Text(msg["user_id"].toString())
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text("收藏"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Collection_Page();
                      }));
                },
              ),

          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("发布校友信息"),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return postPage();
                  }));
            },
          ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text("发公司信息"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return PostCompanyPage();
                      }));
                },
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AboutDialog(
                          applicationName: "校园云邦",
                          applicationIcon: Image.asset(
                            "Images/ic_launcher.png",
                            fit: BoxFit.cover,
                          ),
                          applicationVersion: "版本：1.0.0",
                          applicationLegalese: '版本所有：进修的小team',
                          children: <Widget>[
                            Text("邮箱：727824984@qq.com"),
                            Text("制作：进修的小team"),
                          ],
                        );
                      });
                },
                leading: Icon(
                  Icons.report,
                  color: Colors.black12,
                ),
                title: Text("关于",textAlign: TextAlign.left,),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  // size: 17.0,
                ),
              ),
              Container(
                height: 60.0,
              ),
              SizedBox(
                height: 45.0,
                width: 150.0,
                child: RaisedButton(
                  child: Text(
                      '注销',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)

                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPageWidget()),
                    );
                  },
                  shape: StadiumBorder(side: BorderSide()),
                ),
              ),
            ],
          ),
//          Positioned(
//            right: 0,
//            bottom: 0,
//            child:
//            FloatingActionButton(
//                onPressed: () {
//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return postPage();
//                      }));
//                },
//                child: Icon(Icons.add)
//            )
//          )

      )
    );
  }
}

class TopView extends StatelessWidget {
  const TopView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
    onTap: () {
      print("修改头像、姓名、电话");
    },
    child: new Container(
      height: 180.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568471040221&di=0cbf2fee1186347144f88474a0d71b1b&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fdesign%2F00%2F83%2F74%2F96%2F58a40d98e46a4.png"),
              fit: BoxFit.cover)),
      // color: Colors.white,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            margin: new EdgeInsets.only(right: 20.0, top: 10.0),
            child: new IconButton(
                iconSize: 20.0,
                icon: new Icon(Icons.new_releases, color: Colors.white),
                onPressed: () {
                  print("查看消息");
                }),
          ),
          new Container(
            height: 90.0,
            margin: new EdgeInsets.only(top: 20.0),
//              color: Colors.yellow,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.only(left: 15.0),
                    child: ClipOval(
                      child: Image.network(
                        "https://hbimg.huabanimg.com/f2b48ebe46f6e622fb53b34d29fc6e94c8dedb4824297-OP7aJU_fw658",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    )),
                new Container(
                  margin: new EdgeInsets.only(left: 8.0, top: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(msg==null?"":msg["username"],
                          style: TextStyle(
                              color: Color(0xFF777777), fontSize: 18.0),
                          textAlign: TextAlign.left),
                      new Text(msg==null?"":msg["user_id"].toString(),
                          style: TextStyle(
                              color: Color(0xFF555555), fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    ),
  );
  }
}


