import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Details_Page/Recruit_demo.dart';
import 'dart:convert';
import '../Event_bus/Collect_Fresh.dart';

List <Map>list2 = [];
const String url =
    "https://www.fastmock.site/mock/fc6e181f91cee3f42c68e11ccd9a645a/huanbeiwusheng/company";

class Collection_Page extends StatefulWidget {
  Collection_Page({Key key}) : super(key: key);

  _Collection_PageState createState() => _Collection_PageState();
}

class _Collection_PageState extends State<Collection_Page> {
 var eventFlesh;
String cartString="[]" ;
 List <Map>Collection_List3=[ ];

 String fun;
//获得数据
Future<String> getdateInfo()async{
SharedPreferences prefs = await SharedPreferences.getInstance();
 cartString=prefs.getString('cartInfo'); 
setState(() {
  Collection_List3= (json.decode(cartString.toString()) as List).cast();
});

}
 remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    print('清空完成-----------------');
    // notifyListeners();
  }

  @override
  void initState() {
    // TODO: implement initState
  
     getdateInfo();

    eventFlesh= eventBus.on<ProductContentEvent>().listen((event){

getdateInfo();
     });
     
    super.initState();
  }
@override
  void dispose() {
    
    // TODO: implement dispose
    super.dispose();
   this. eventFlesh.cancel();
   this.eventFlesh=Null;
  }

  @override
  Widget build(BuildContext context) {
   
    if (Collection_List3!=null) {
        return Scaffold(
        
        body:EasyRefresh(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                 
          title: Text("收藏"),
          backgroundColor: Colors.grey,
          centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: (){
           setState(() {
            remove(); 
           });
          },
        )
      ],
              ),
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
            onTap:(){
              Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Recruit_Page(Collection_List3[index]);
                    }));
            } ,
            child: Card(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              // height: 100.0,
              // width: width,
              // color: Colors.grey[200],
              child: Image.network(Collection_List3[index]['logourl'],fit: BoxFit.cover,height: 60,),
            ),
            Container(
              // width: width,
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(Collection_List3[index]['title'],style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),

                    child: Text(Collection_List3[index]['introduce'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15
                      ),
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
        childCount: Collection_List3.length,
      ),
    )
            ],
          ),
        )

        );
    } else {
      return Scaffold(
        body: Center(
          child: Text("loading......."),
        ),
      );
    }
   
  }
}

