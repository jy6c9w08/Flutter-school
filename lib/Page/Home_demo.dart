import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import '../Details_Page/Recruit_demo.dart';
import './Search_demo.dart';
import './Image_demo.dart';
import '../Comment/Lodaing_demo.dart';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String url =
    "https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/company";
const String url1 =
    "https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/firstpage";

class Home_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Home_PageState();
  }
}

class _Home_PageState extends State<Home_Page> {
  int _gridCount = 10;
  var mlist;
  var mlist1;
  fetchPosts() async {
    Dio dio = new Dio();
    final response = await dio.get(url);//推荐数据
    final response1 = await dio.get(url1);//获得轮播数据
    if (response.statusCode == 200) {
      var result = response.data;
      setState(() {
        mlist = result['posts'];
        // print("数据为$mlist");
      });
    } else {
      throw Exception('Failed to fetch posts.');
    }
    if (response1.statusCode == 200) {
      var result1 = response1.data;
      setState(() {
        mlist1 = result1['date'];
        // print("qing数据为${mlist1}");
      });
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPosts();
    super.initState();
  }
  //标题组件
  Widget TitleWidget(String title){
    return  SliverToBoxAdapter(
                  child: Container(
                      child: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  )),
                );
  }
//提示没有更多信息
  Widget NoMore() {
   
      return  _gridCount==mlist.length
          ? Text("--我是有底线的--",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),)
          : Text("");
  }
  @override
  Widget build(BuildContext context) {
    if (mlist != null) {
      return new Scaffold(
        appBar: new AppBar(

          backgroundColor: Colors.white,
          title: Search_Demo(mlist: mlist),
          automaticallyImplyLeading: false,
        ),
        body: EasyRefresh.builder(
          header: MaterialHeader(),
          footer: MaterialFooter(),
          builder: (context, physics, header, footer) {
            return CustomScrollView(
              // physics: null,
              physics:_gridCount >=mlist.length?null:physics, 
              slivers: <Widget>[
                header,
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 200.0,
                  // pinned: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    background: SwiperDemo_Home(
                      mlist1: mlist1[0],
                    ),
                  ),
                ),
               TitleWidget("校榜"),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    child: RowDemo(
                      mlist: mlist1[1],
                    ),
                  ),
                ),
               TitleWidget("推荐"),
                SliverGrid(
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    
                    (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Recruit_Page(mlist[index]);
                          }));
                        },
                        child: Card(
                          child: Container(
                            // height: 200,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 70.0,
                                  // width: width,
                                  // color: Colors.grey[200],
                                  child: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Image.network(
                                    mlist[index]['logourl'],
                                    // fit: BoxFit.cover,
                                    height: 20,
                                  ),
                                  )
                                ),
                                Container(
                                  // width: width,
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          mlist[index]['title'],
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: .0),
                                        child: Text(
                                          mlist[index]['introduce'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _gridCount,
                  ),
                ),
                SliverToBoxAdapter(
                  child:NoMore() ,
                ),
                // _gridCount==mlist.length?Text("我是有底线的"):Text(""),
                footer,
              ],
            );
          },
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _gridCount = 10;
              });
            });
          },
          onLoad:
          () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (_gridCount < mlist.length) {
                setState(() {
                  _gridCount += 10;
                });
              } 
              else {
                setState(() {
                  _gridCount = mlist.length;
                  
                  Fluttertoast.showToast(msg: "到底了", fontSize: 14);
                });
              }

              // print('onLoad');
            });
          },
        ),
      );
    } else {
      return LoadingWidget();
      
    }
  }
}

class Search_Demo extends StatelessWidget {
  Search_Demo({this.mlist, Key key}) : super(key: key);
  var mlist;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 500.0,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            SizedBox(),
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Text("搜索"),
          ],
        ),
        color: Colors.white,
        onPressed: () {
          print("跳转搜索页面");
          showSearch(context: context, delegate: SearchBar(mlist: mlist));
        },
        shape: StadiumBorder(side: BorderSide()),
      ),
    );
  }
}

class RowDemo extends StatelessWidget {
  var mlist;
  RowDemo({this.mlist, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int item) {
        return Card(
            child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Image_View_Page(mlist: mlist['middle']);
              }));
              print("点击图片");
            },
            child: Image.network(
              mlist['middle'][item]['redurl'],
              fit: BoxFit.cover,
            ),
          ),
        ));
      },
    );
  }
}

class SwiperDemo_Home extends StatelessWidget {
  SwiperDemo_Home({this.mlist1, Key key}) : super(key: key);
  var mlist1;
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
              mlist1['top'][index]['url'],
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
