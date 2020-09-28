import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class postPage extends StatefulWidget {
  @override
  _postPageState createState() => _postPageState();
}

class _postPageState extends State<postPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "发布信息",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text("发布"),
          )
        ],
      ),
      body: bodyPage(),
    );
  }
}

class bodyPage extends StatefulWidget {
  @override
  _bodyPageState createState() => _bodyPageState();
}

class _bodyPageState extends State<bodyPage> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        child: SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Center(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[Icon(Icons.add), Text("添加图片")],
            ),
          )
        ),
        TextField(
          decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              labelText: '姓名'),
        ),
        TextField(
          decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              labelText: '毕业时间'),
        ),
        TextField(
          decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              labelText: '联系方式'),
        ),
        TextField(
          decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              labelText: '座右铭'),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          minLines: 1,
          controller: _textEditingController,
          decoration: InputDecoration(
              fillColor: Colors.blue.shade100,
              filled: true,
              labelText: '履历'),
          onSubmitted: (value) {
            if (_textEditingController.text.isNotEmpty) {
//                _sendMsg(_textEditingController.text);
              _textEditingController.text = '';
            }
          },
        ),
      ],
    )),
    );
  }
}
