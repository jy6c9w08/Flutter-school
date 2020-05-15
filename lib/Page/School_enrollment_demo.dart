import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Details_Page/Recruit_demo.dart';
import 'package:dio/dio.dart';
import '../Comment/Lodaing_demo.dart';
import '../Comment/Screen.dart';

const String url =
    "https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/company";

class School_enrollment_Page extends StatefulWidget {
  School_enrollment_Page({Key key}) : super(key: key);

  _School_enrollment_PageState createState() => _School_enrollment_PageState();
}

class _School_enrollment_PageState extends State<School_enrollment_Page>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // print('初始化 数据...');

    _tabController = new TabController(
        vsync: this, //固定写法
        length: 6 //指定tab长度
        );

    //添加监听
    _tabController.addListener(() {
      var index = _tabController.index;
      var previousIndex = _tabController.previousIndex;
      print("index: $index");
      print('previousIndex: $previousIndex');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
                //  strokeCap: StrokeCap.round,
                borderSide: BorderSide(
                  color: Color(0xff2fcfbb),
                  width: 3,
                ),
                insets: EdgeInsets.only(bottom: 0)),
            tabs: <Widget>[
              Tab(
                text: '软院',
              ),
              Tab(
                text: '电子',
              ),
              Tab(
                text: '环境',
              ),
              Tab(
                text: '土木',
              ),
              Tab(
                text: '工程',
              ),
              Tab(
                text: '自动化',
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: List_demo(),
          ),
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'TabPage 3',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'TabPage 4',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'TabPage 5',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'TabPage 6',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            color: Color(0xffffffff),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'TabPage 7',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class List_demo extends StatefulWidget {
  @override
  List_demoState createState() => new List_demoState();
}

class List_demoState extends State<List_demo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
//定义初始加载数量
  int _listCount = 10;
  var mlist;

  @override
  void initState() {
    super.initState();

    fetchPosts();
  }

  fetchPosts() async {
    Dio dio = new Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      var result = response.data;
      setState(() {
        mlist = result['posts'];
        // print("数据为$mlist");
      });
    } else {
      throw Exception('Failed to fetch posts.');
    }
  }

//提示没有更多信息
  Widget NoMore(int index) {
    return index == mlist.length
        ? Text(
            "--我是有底线的--",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          )
        : Text("");
  }

  @override
  Widget build(BuildContext context) {
    ScreenSave.init(context);
    if (mlist != null) {
      return Container(
        height: double.infinity,
        color: Colors.grey[100],
        child: EasyRefresh(
          header: MaterialHeader(),
          footer: MaterialFooter(),
          onRefresh: null,
          onLoad: _listCount >= mlist.length
              ? null
              : () async {
                  await Future.delayed(Duration(seconds: 2), () {
                    if (_listCount < mlist.length) {
                      setState(() {
                        _listCount += 10;
                      });
                    } else {
                      setState(() {
                        _listCount = mlist.length;
                        Fluttertoast.showToast(msg: "到底了", fontSize: 14);
                      });
                    }
                  });
                },
          child: ListView.builder(
            // padding: EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Recruit_Page(mlist[index]);
                  }));
                },
                child: Card(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                    // color: Colors.grey[200],
                                    child: Image.network(
                                        mlist[index]['logourl']))),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 5.0),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      mlist[index]['title'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    width: 120.0,
                                    height: 30.0,
                                  ),

                                  // SizedBox(height: 15,),
                                  Container(
                                    child: Text(
                                      mlist[index]['introduce'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NoMore(index + 1)
                  ],
                )),
              );
            },
            itemCount: _listCount,
          ),
        ),
      );
    } else {
      return LoadingWidget();
    }
  }
}
