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

class TwoLevelExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TwoLevelExampleState();
  }
}

class _TwoLevelExampleState extends State<TwoLevelExample> {
  RefreshController _refreshController1 = RefreshController();
  RefreshController _refreshController2 = RefreshController();
  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _refreshController1.headerMode.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _refreshController1.position.jumpTo(0);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshConfiguration.copyAncestor(
      context: context,
      enableScrollWhenTwoLevel: true,
      maxOverScrollExtent: 120,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: _tabIndex != 0,
              child: LayoutBuilder(
                builder: (_, c) {
                  return SmartRefresher(
                    header: TwoLevelHeader(
                      textStyle: TextStyle(color: Colors.white),
                      displayAlignment: TwoLevelDisplayAlignment.fromTop,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/secondfloor.jpg"),
                            fit: BoxFit.cover,
                            // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
                            alignment: Alignment.topCenter),
                      ),
                      twoLevelWidget: TwoLevelWidget(),
                    ),
                    child: CustomScrollView(
                      physics: ClampingScrollPhysics(),
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(
                            child: Scaffold(
                              appBar: AppBar(),
                              body: Column(
                                children: <Widget>[
                              /*    RaisedButton(
                                    onPressed: () {
                                      _refreshController1.requestTwoLevel();
                                    },
                                    child: Text("点击这里打开二楼!"),
                                  )*/
                                ],
                              ),
                            ),
                            height: 500.0,
                          ),
                        )
                      ],
                    ),
                    controller: _refreshController1,
                    enableTwoLevel: true,
                    enablePullDown: true,
                    enablePullUp: true,
                    onLoading: () async {
                      await Future.delayed(Duration(milliseconds: 2000));
                      _refreshController1.loadComplete();
                    },
                    onRefresh: () async {
                      await Future.delayed(Duration(milliseconds: 2000));
                      _refreshController1.refreshCompleted();
                    },
                    onTwoLevel: () async{
                      print('oooooooo0000000000000000000000000000nTwoLevel');
                    },
                    onOffsetChange: (boll,int){
                      print('~~~~~~~~~~~~~${boll}--------------------${int}');
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class TwoLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/secondfloor.jpg"),
            // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果,关联到TwoLevelHeader,如果背景一致的情况,请设置相同
            alignment: Alignment.topCenter,
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Wrap(
              children: <Widget>[
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {},
                  child: Text("登陆"),
                ),
              ],
            ),
          ),
          Container(
            height: 60.0,
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                SmartRefresher.of(context).controller.twoLevelComplete();
              },
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}
