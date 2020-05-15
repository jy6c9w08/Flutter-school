import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';


class Image_View_Page extends StatelessWidget {
  var mlist;
 Image_View_Page({this.mlist, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new PageView.custom(
    childrenDelegate: new SliverChildBuilderDelegate(
        (context, index) {
            return  PhotoView(
      imageProvider: NetworkImage(mlist[index]['redurl']),
    );
        },
        childCount: mlist.length,
    ),
);
  }
}