import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

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

  static bottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }

  // 初始化设计稿尺寸
  static final double dessignWidth = 375.0;
  static final double dessignHeight = 1335.0;

  // static final double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;

  // flutter_screenutil px转dp
  // num dp(double dessignValue) => ScreenUtil.getInstance().setWidth(dessignValue);
}
