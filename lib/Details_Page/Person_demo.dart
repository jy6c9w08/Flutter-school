import 'package:flutter/material.dart';



class Person_Page extends StatelessWidget{
    List<Widget> list = List();
  var date;
  Person_Page({this.date});
  @override
  Widget build(BuildContext context) {
 for (int i = 0; i<date['experience'].length; i++) {
  //  print("数据为${date['experience'][i]['title']}");
      list.add(
        ListTile(
          title: Text(
            date['experience'][i]['subtitle'],
            style: TextStyle(fontSize: 20.0),
          ),
          // subtitle: Text(date['experience'][i]['subtitle']),
          trailing: Icon(Icons.arrow_right),
        ),
      );
    }


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
                child: Image.network(date['photo']),
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
                             
                              title: Text(
                                date['name'],
                                style: TextStyle(fontSize: 40.0),
                              ),
                              trailing: Icon(Icons.favorite),
                            ),
                            
                            ListTile(
                             
                              leading: Icon(Icons.school),
                              title: Text("XX级优秀毕业生"),
                              
                            ),
                            Container(
                              width: double.infinity,
                              height: 3.0,
                              color: Color(0xFFF3F3F3),
                            ),
                            ListTile(
                              
                              title: Text("qq${date['qq']}"),
                              leading: Icon(Icons.contact_phone),
                             
                            ),
                            Container(
                              width: double.infinity,
                              height: 3.0,
                              color: Color(0xFFF3F3F3),
                            ),
                           
                            ExpansionTile(
                              leading: Icon(Icons.border_color),
                              title: Text("座右铭"),
                              children: <Widget>[
                                Text(date['motto'],
                                style: TextStyle(
                                  fontSize: 20.0
                                ),)
                              ],
                            ),
                             ExpansionTile(
                              leading: Icon(Icons.web),
                              title: Text("履历"),
                              children:list,
                         
                              
                            ),
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

