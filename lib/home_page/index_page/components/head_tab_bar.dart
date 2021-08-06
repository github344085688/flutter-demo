import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';
class HeadTabBar extends StatefulWidget {
  const HeadTabBar({Key key}) : super(key: key);

  @override
  _HeadTabBar createState() => _HeadTabBar();
}

class _HeadTabBar extends State<HeadTabBar> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 10,
                child: Container(
                  height: ScreenApdar.setHeight(30),
                  padding: EdgeInsets.all(0),
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(text: "首页"),
                      Tab(text: "手机"),
                      Tab(text: "食品"),
                      Tab(text: "家电"),
                      Tab(text: "生鲜"),
                      Tab(text: "家装"),
                      Tab(text: "运动"),
                      Tab(text: "电脑办公"),
                      Tab(text: "家居厨房"),
                      Tab(text: "美妆"),
                      Tab(text: "母婴童装"),
                      Tab(text: "个护清洁"),
                      Tab(text: "男装"),
                      Tab(text: "女装"),
                      Tab(text: "图书"),
                    ],
                    isScrollable: true,
                    labelColor: Theme.of(context).dividerColor,
                    indicatorPadding: EdgeInsets.only(bottom: 1.0, top: 1.0),
                    indicatorWeight: 1.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Theme.of(context).dividerColor,
                    labelStyle: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  height: ScreenApdar.setHeight(30),
                  width: double.infinity,
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 20.0,
                      icon: Icon(
                        Icons.apps,
                        color: Theme.of(context).dividerColor,
                      ),
                      onPressed: null),
                )),
          ],
        ),
      );
}
