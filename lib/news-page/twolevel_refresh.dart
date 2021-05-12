/*
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * Time:  2019-06-26 16:28
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';


class TwoLevelExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TwoLevelExampleState();
  }
}

class _TwoLevelExampleState extends State<TwoLevelExample> {

  GlobalKey _myKey = new GlobalKey();
  ScrollController _controller;
  int index=0;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //来监听 节点是否build完成
    WidgetsBinding widgetsBinding=WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback){
      Timer.periodic(new Duration(seconds: 5), (timer){
        index+=_myKey.currentContext.size.height.toInt();
        _controller.animateTo((index).toDouble(), duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
        //滚动到底部从头开始
        if((index-_myKey.currentContext.size.height.toInt()).toDouble()>_controller.position.maxScrollExtent){
          _controller.jumpTo(_controller.position.minScrollExtent);
          index=0;
        }
      });
    });
    _controller = new ScrollController(initialScrollOffset: 0);
    _controller.addListener(() {
      print(_controller.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _myKey,
        //禁止手动滑动
        physics: new NeverScrollableScrollPhysics(),
        itemCount:6,
        //item固定高度
        itemExtent:ScreenApdar.setHeight(21),
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text("【猎毒人】吕云鹏计楚" + index.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          );
        });
  }


}
