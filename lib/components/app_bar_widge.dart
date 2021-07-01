import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/components/marquee.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/servers/json_servers.dart' show asset;
import 'package:flutter_demo/style/style.dart';
import 'dart:convert';

class AppBarWidge extends StatefulWidget {
  double _toolbarHeight;
  double _searchRight;
  double _opacity;
  double _appBarOpacity;

  AppBarWidge({
    Key key,
    double initBarHeight: 85,
    double setBarHeight: 41,
    double toolbarHeight,
    double initSsearchRight: 85,
    double searchRight: 0,
    double searchButtom: 4.0,
    double opacity: 1,
    double expandedHeight: 78,
    double appBarOpacity: 1,
  })  : _toolbarHeight = ScreenApdar.setHeight(toolbarHeight),
        _searchRight = ScreenApdar.setWidth(
            (initBarHeight - toolbarHeight) * 5 < 100
                ? (initBarHeight - toolbarHeight) * 5
                : 100),
        _opacity = opacity,
        _appBarOpacity = appBarOpacity,
        super(key: key);

  @override
  _AppBarWidge createState() => _AppBarWidge();
}

class _AppBarWidge extends State<AppBarWidge>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation _animation;
  List _expandStateList = [];

  void init() async {
    var setData = await asset.get('assets/json/creads.json');
    setState(() {
      _expandStateList = json.decode(setData);
    });
  }

  @override
  void initState() {
    init();
    super.initState();
    /* _controller = AnimationController(
         duration: Duration(milliseconds : 2), vsync: this);
     _animation = ColorTween(begin: Color(0xFF01EFEB), end: Color(0xFF012831))
         .animate(_controller);*/

    // ;

    // _controller.addListener(() {
    //   setState(() {});
    //   print(widget._iconBgColor);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Color _searchBg = ComponentStyle.TITLE_TEXT_COLOR;
   /* Color.fromRGBO(
        75 + (widget._searchRight * 2.24).toInt(),
        112 + (widget._searchRight * 2.08).toInt(),
        120 + (widget._searchRight * 1.94).toInt(),
        1);*/

    Color _appBarBg = Color.fromRGBO(
        /* 1+ (widget._searchRight * 2.24).toInt(),
        47+ (widget._searchRight * 2.08).toInt(),
        61+ (widget._searchRight * 1.94).toInt(),*/
        44,
        52,
        65,
        1 - widget._opacity);
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: widget._toolbarHeight,
        // width: double.maxFinite,
        child: Opacity(
          opacity: widget._appBarOpacity,
          child: Container(
            width: double.infinity,
            color: _appBarBg,
            padding: EdgeInsets.only(
                left: ScreenApdar.setWidth(15),
                right: ScreenApdar.setWidth(15)),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned(
                  // top: -(widget._statusBarHeight),
                  left: ScreenApdar.setWidth(-15),
                  right: ScreenApdar.setWidth(-15),
                  bottom: 0,
                  child: Opacity(
                    opacity: widget._appBarOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: ScreenApdar.setHeight(27),
                  height: ScreenApdar.setHeight(30),
                  child: Opacity(
                    opacity: widget._opacity,
                    child: Image.asset(
                      'assets/images/logo-index2.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: widget._searchRight,
                  bottom: ScreenApdar.setHeight(4),
                  child: Container(
                      height: ScreenApdar.setHeight(25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: _searchBg,
                          border: Border.all(
                              color: ComponentStyle.MALL_FOCUS_BG,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.search,
                                size: ScreenApdar.setFontSize(20),
                                color: ComponentStyle.AVERAGE_COLOR),
                          ),
                          Expanded(
                            flex: 8,
                            child: Marquee(_expandStateList.length-1,
                                (BuildContext context, int index) {
                              return Text(_expandStateList[index]['username'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color:  ComponentStyle.LINE_COLOR,
                                      decoration: TextDecoration.none,
                                      fontSize: 16.0));
                            }),
                            /*child: Text('${widget._appBarOpacity}',
                                style: TextStyle(
                                    color:  _iconBgColor,
                                    decoration: TextDecoration.none,
                                    fontSize: 18.0)),*/
                          ),
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.camera_alt,
                                size: ScreenApdar.setFontSize(20),
                                color: ComponentStyle.AVERAGE_COLOR),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  top: ScreenApdar.setHeight(26),
                  right: ScreenApdar.setWidth(65),
                  height: ScreenApdar.setHeight(30),
                  width: ScreenApdar.setWidth(30),
                  child: Icon(Icons.biotech_rounded,
                      color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)),
                ),
                Positioned(
                  top: ScreenApdar.setHeight(26),
                  right: ScreenApdar.setWidth(40),
                  height: ScreenApdar.setHeight(30),
                  width: ScreenApdar.setWidth(30),
                  child: Icon(Icons.crop_free,
                      color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)),
                ),
                Positioned(
                    top: ScreenApdar.setHeight(26),
                    right: ScreenApdar.setWidth(10),
                    height: ScreenApdar.setHeight(30),
                    width: ScreenApdar.setWidth(30),
                    child: Icon(Icons.message,
                        color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)))
              ],
            ),
          ),
        ));
  }
}
