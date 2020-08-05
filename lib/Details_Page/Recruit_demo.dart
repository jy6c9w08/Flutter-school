import '../Event_bus/Collect_Fresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '../Comment/Sharedpreference_demo.dart';

const String url =
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568549668511&di=125274065576c99df1497476b55fcef2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F17%2F70%2F28%2F557abe818985d_1024.jpg";

class Recruit_Page extends StatefulWidget {
  Recruit_Page(
    this.mlist, {
    Key key,
  }) : super(key: key);
  var mlist;

  _Recruit_PageState createState() => _Recruit_PageState(mlist);
}

class _Recruit_PageState extends State<Recruit_Page> {
  _Recruit_PageState(this.mlist);

  var mlist;
  int isCollect = -1;
  String cartString = "";
  // List title;
  List<Widget> list = List();
  _launchURL() async {
    var url = '${mlist['pushurl']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//储存数据
  save(key, title, introduce, phone, logourl, topimageurl, pushurl,
      comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    if (!isHave) {
      tempList.add({
        'key': key,
        'title': title,
        'introduce': introduce,
        'phone': phone,
        'logourl': logourl,
        'topimageurl': topimageurl,
        'pushurl': pushurl,
        'comment': comment,
      });
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); //进行持久化
  }
  Future<String> loadData() async {
     String ishave="";
     ishave = await Storage.getString('cartInfo');
     return ishave;
   }
//判断数据存在
  isdate() async {
//    String date = json.encode(mlist);
    loadData().then((value){
//      print("this is$value");
    if (value==[]) {
        setState(() {
          isCollect = -1;
        });
        print("false");
      }else if (value.contains(mlist['title'])) {
      setState(() {
        isCollect = 1;
      });
      print("ture");
    }
    else {
      setState(() {
        isCollect = -1;
      });
    }
    });
//     print(ishave);

    // print('123$ishave');
  }

  @override
  void initState() {
    // TODO: implement initState
    isdate();
    for (var i = 0; i < mlist['comment'].length; i++) {
      list.add(
        ListTile(
          title: Text(
            mlist['comment'][i]['name'],
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(mlist['comment'][i]['text']),
          // trailing: Icon(Icons.arrow_right),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey.withOpacity(0.5),
            title: Text("信息详情"),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 230.0,
                child: Image.network(mlist['topimageurl']),
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: PhysicalModel(
                    color: Colors.grey.withOpacity(0.5),
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10),
                    child: Card(
                      elevation: 4.0, //阴影
                      color: Colors.white, //背景色

                      child: Column(
                        children: <Widget>[
                          ListTile(
                            // onTap: (){},
                            // leading: Icon(Icons.local_activity),
                            title: Text(
                              mlist['title'],
                              style: TextStyle(fontSize: 40.0),
                            ),
                            trailing: IconButton(
                              icon: Icon(isCollect == 1
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              onPressed: () async {
                                //  Map ishave =
                                //     json.decode(  await Storage.getString('cartInfo'));
                                if (isCollect == -1) {
                                  setState(() {
                                    isCollect = isCollect * -1;
                                  });
                                  save(
                                    mlist['key'],
                                    mlist['title'],
                                    mlist['introduce'],
                                    mlist['phone'],
                                    mlist['logourl'],
                                    mlist['topimageurl'],
                                    mlist['pushurl'],
                                    mlist['comment'],
                                  );
                                  Fluttertoast.showToast(
                                      msg: "收藏成功",
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 14);
                                } else {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  cartString = prefs.getString('cartInfo');
                                  List tempList = (json
                                      .decode(cartString.toString()) as List);

                                  int delIndex = 0;
                                  for (int i = 0;; i++) {
                                    if (tempList[i]['title'].toString() ==
                                        mlist['title'].toString()) {
                                      delIndex = i;
                                      break;
                                    }
                                  }

                                  tempList.removeAt(delIndex);
                                  cartString = json.encode(tempList).toString();
                                  prefs.setString('cartInfo', cartString);

                                  setState(() {
                                    isCollect = isCollect * -1;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "取消收藏",
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 14);
                                }

                                eventBus.fire(ProductContentEvent());
                                print("点击收藏");
                              },
                              color: Colors.blueAccent,
                              highlightColor: Colors.red,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 3.0,
                            color: Color(0xFFF3F3F3),
                          ),
                          ListTile(
                            title: Text(mlist['phone']),
                            leading: Icon(Icons.contact_phone),
                          ),
                          Container(
                            width: double.infinity,
                            height: 3.0,
                            color: Color(0xFFF3F3F3),
                          ),
                          ExpansionTile(
                            leading: Icon(Icons.border_color),
                            title: Text("简介"),
                            children: <Widget>[
                              Text(
                                mlist['introduce'],
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                          ExpansionTile(
                            leading: Icon(Icons.grade),
                            title: Text("学长心得"),
                            children: list,
                          ),
                          ExpansionTile(
                              leading: Icon(Icons.web),
                              title: Text("推送链接"),
                              children: <Widget>[
                                ListTile(
                                  onTap: _launchURL,
                                  title: Text("官网推送"),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )),
            ]),
          )
        ],
      ),
    );
  }
}

class SwiperDemo extends StatelessWidget {
  const SwiperDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: GestureDetector(
            onTap: () {
              print("点击图片");
            },
            child: Image.network(
              "https://hbimg.huabanimg.com/8cda8b01dd4f0359180d76e456ddcb501aa34ffb51311-1loUZx_fw658",
              fit: BoxFit.cover,
            ),
          ),
        ));
      },
      itemCount: 5,
      viewportFraction: 0.8,
      scale: 0.9,
      autoplay: true,
    );
  }
}
