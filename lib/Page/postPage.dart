import 'package:flutter/material.dart';
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
        title: Text("发布评价",style: TextStyle(
          color: Colors.black
        ),),
        actions: <Widget>[
          FlatButton(onPressed: (){}, child: Text(
            "发布"
          ),
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
      height: double.infinity,
      child:TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        controller: _textEditingController,
        decoration: null,
            onSubmitted: (value) {
              if (_textEditingController.text.isNotEmpty) {
//                _sendMsg(_textEditingController.text);
                _textEditingController.text = '';
              }
            },
      ),
    );
  }
}
