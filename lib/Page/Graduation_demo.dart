import 'package:flutter/material.dart';
import '../Details_Page/Person_demo.dart';
import 'package:dio/dio.dart';
const String url =
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568549668511&di=125274065576c99df1497476b55fcef2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F17%2F70%2F28%2F557abe818985d_1024.jpg";

class Graduation_Page extends StatefulWidget {
  Graduation_Page({Key key}) : super(key: key);

  _Graduation_PageState createState() => _Graduation_PageState();
}

class _Graduation_PageState extends State<Graduation_Page>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    print('初始化 数据...');
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
            padding: EdgeInsets.all(20),
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
  List_demo({Key key}) : super(key: key);

  _List_demoState createState() => _List_demoState();
}

class _List_demoState extends State<List_demo> {
 var mlist;
fetchPosts() async {
    Dio dio = new Dio();
    final response = await dio.get("https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/peopleruanjian");
    if (response.statusCode == 200) {
      var result = response.data;
       setState(() {
        mlist = result['date'];
        // print("数据为firsttext$mlist");
      });
     
    } else {
      throw Exception('Failed to fetch date.');
    }
  }

  @override
  void initState() {
    fetchPosts();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    fetchPosts();
    if(mlist!=null){
      return ListView(
      children: <Widget>[
        ExpansionTile_demo(mlist[0]),
        ExpansionTile_demo(mlist[1]),
        ExpansionTile_demo(mlist[2]),
        ExpansionTile_demo(mlist[3]),
        ExpansionTile_demo(mlist[4]),
      ],
    );
    }
    else{
      return Center(
        child: Text("loading....."),
      );
    }
  }
}

class ExpansionTile_demo extends StatelessWidget {
  List<Widget> titlelist = List();
  ExpansionTile_demo(this.date, {Key key}) : super(key: key);
 var date;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < date['people'].length; i++) {
      titlelist.add(
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return Person_Page(date: date['people'][i],);
            }));
          },
          leading: CircleAvatar(backgroundImage: NetworkImage(date['people'][i]['photo'])),
          title: Text(date['people'][i]['name']),
          subtitle: Text(date['people'][i]['achievement']),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      );
    }

    return Padding(
        padding: EdgeInsets.all(3),
        child: PhysicalModel(
          color: Colors.grey.withOpacity(0.5),
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: Card(
              elevation: 4.0, //阴影
              color: Colors.white, //背景色
              child: ExpansionTile(
                title: Text(date["title"]),
                children: titlelist,
                
              )),
        ));
  }
}
