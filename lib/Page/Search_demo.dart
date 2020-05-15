import 'package:flutter/material.dart';
import '../Details_Page/Recruit_demo.dart';

const String url =
    "https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/company";

class SearchBarDemo extends StatefulWidget {
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBarDemo'),
        // 使用搜索那个放大镜图标
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              // 调用写好的方法
              showSearch(context: context,delegate: SearchBar());
            },
          )
        ],
      ),
    );
  }
}


class SearchBar extends SearchDelegate<String>{
  var mlist;

SearchBar({this.mlist});
  // 点击清楚的方法
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        // 点击把文本空的内容清空
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  // 点击箭头返回
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        // 使用动画效果返回
        icon: AnimatedIcons.menu_arrow,progress: transitionAnimation,
      ),
      // 点击的时候关闭页面（上下文）
      onPressed: (){
        close(context, null);
      },
    );
  }

  // 点击搜索出现结果
  @override
  Widget buildResults(BuildContext context) {
  return  MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
        itemCount: mlist.length,
        itemBuilder: (context,index){
         if (mlist[index]["title"].contains(query)) {
            return  ListTile(
            onTap: (){
              print("点击跳转${mlist[index]}");
              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Recruit_Page(mlist[index]);
          }));
            },
              title:Text( mlist[index]["title"]),
              subtitle: Text(mlist[index]["introduce"],
              style: TextStyle(color: Colors.grey),
               maxLines: 1,
                      overflow: TextOverflow.ellipsis,
              ),
          );
         } else {
           return Container(
             height: 0.0,
           );
         }
        }
    ),
      );
  }
  ThemeData appBarTheme(BuildContext context) {
  assert(context != null);
  final ThemeData theme = Theme.of(context);
  assert(theme != null);
  return theme.copyWith(
    primaryColor: Colors.white,
    primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
    primaryColorBrightness: Brightness.light,
    primaryTextTheme: theme.textTheme,
  );
}

  // 搜索下拉框提示的方法
   @override
  Widget buildSuggestions(BuildContext context) {
    // 定义变量 并进行判断
  
    if (query.length==0) {
      
      // print("请求的数据为${mlist}");
         return Column(
           children: <Widget>[
            Container(
              child:  Text("推荐搜索",
             style: TextStyle(
               fontWeight: FontWeight.bold
             ),),
            ),
             Padding(
      child: Wrap(
        children: <Widget>[
          ButtonItem(text: mlist[1]["title"],mlist:mlist[1],),
          ButtonItem(text: mlist[5]["title"],mlist:mlist[5],),
          ButtonItem(text: mlist[2]["title"],mlist:mlist[2],),
          ButtonItem(text: mlist[7]["title"],mlist:mlist[7],),
          ButtonItem(text: mlist[4]["title"],mlist:mlist[4],),
          ButtonItem(text: mlist[6]["title"],mlist:mlist[6],),
          ButtonItem(text: mlist[16]["title"],mlist:mlist[16],),
          
        ],
        spacing: 12,
        runSpacing: 13,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.end,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    )
           ],
         );
    } else {
      return  MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
        itemCount: mlist.length,
        itemBuilder: (context,index){
         if (mlist[index]["title"].contains(query)) {
            return  ListTile(
            onTap: (){
              print("点击跳转${mlist[index]}");
              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Recruit_Page(mlist[index]);
          }));
            },
              title: RichText(
                  text: TextSpan(
                    // 获取搜索框内输入的字符串，设置它的颜色并让让加粗
                      text: mlist[index]["title"].substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          //获取剩下的字符串，并让它变成灰色
                            text: mlist[index]["title"].substring(query.length),
                            style: TextStyle(color: Colors.grey))
                      ]
                  )
              ),
              subtitle: Text(mlist[index]["introduce"],
              style: TextStyle(color: Colors.grey),
               maxLines: 1,
                      overflow: TextOverflow.ellipsis,
              ),
          );
         } else {
           return Container(
             height: 0.0,
           );
         }
        }
    ),
      );
    }
    
  }
 
}
class ButtonItem extends StatelessWidget {
  ButtonItem({
    Key key,
     this.text,
     this.mlist,
  }) : super(key: key);

   var text;
   var mlist;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.text),
      color: Theme.of(context).buttonColor,
      onPressed: () {
        print("点击");
         Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Recruit_Page(mlist);
              }));
      },
    );
  }
}