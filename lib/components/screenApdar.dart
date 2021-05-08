import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenApdar {
  static init(context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        allowFontScaling: false,
        orientation: Orientation.portrait);
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static setFontSize(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }
  static statusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }
}
