
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ScreenSave{
//初始化引用
  static init(context){
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
  }
  //适配高度
  static height(double value){
     return ScreenUtil().setHeight(value);
  }
    //适配宽度
  static width(double value){
      return ScreenUtil().setWidth(value);
  }
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }

  static getScreenPxHeight(){
    return ScreenUtil.screenHeight;
  }
  static getScreenPxWidth(){
    return ScreenUtil.screenWidth;
  }
  // ScreenUtil.screenHeight 
}

