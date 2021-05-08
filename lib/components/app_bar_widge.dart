import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
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
  })  : _toolbarHeight = toolbarHeight,
        _searchRight =(initBarHeight- toolbarHeight)*5<100?(initBarHeight- toolbarHeight)*5:100,
        _opacity = opacity,
        _appBarOpacity = appBarOpacity,
        super(key: key);
  @override
  _AppBarWidge createState() => _AppBarWidge();
}

class _AppBarWidge extends State<AppBarWidge> with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation _animation;

   @override
   void initState() {
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
    Color _searchBg= Color.fromRGBO(
        1+ (widget._searchRight * 2.24).toInt(),
        47+ (widget._searchRight * 2.08).toInt(),
        61+ (widget._searchRight * 1.94).toInt(),
        1-(widget._searchRight * 0.8).toInt()/100);
    Color _iconBgColor= Color.fromRGBO(
         98 - (widget._searchRight * 0.8).toInt(),
         222 - (widget._searchRight * 1.75).toInt(),
         255 - (widget._searchRight * 1.94).toInt(),
        1);

    Color _appBarBg= Color.fromRGBO(
       /* 1+ (widget._searchRight * 2.24).toInt(),
        47+ (widget._searchRight * 2.08).toInt(),
        61+ (widget._searchRight * 1.94).toInt(),*/
        255,255,255,
        1 - widget._opacity);
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height:widget._toolbarHeight,
        // width: double.maxFinite,
        child: Opacity(
          opacity: widget._appBarOpacity,
          child: Container(
            width: double.infinity,
            color: _appBarBg,
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned(
                  // top: -(widget._statusBarHeight),
                  left: -15.0,
                  right: -15.0,
                  bottom: 0,
                  child: Opacity(
                    opacity: widget._appBarOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                        //背景装饰
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 24.0,
                  height: 30.0,
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
                  bottom: 4,
                  child: Container(
                      height: 28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: _searchBg,
                          border: Border.all(
                              color: Theme.of(context).indicatorColor,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.search,
                                size: 20.0,
                                color: _iconBgColor),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text('${widget._appBarOpacity}',
                                style: TextStyle(
                                    color:  _iconBgColor,
                                    decoration: TextDecoration.none,
                                    fontSize: 18.0)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.camera_alt,
                                size: 20.0,
                                color:  _iconBgColor),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  top: 26.0,
                  right: 65.0,
                  height: 30.0,
                  width: 30.0,
                  child: Icon(Icons.biotech_rounded,
                      color:  _iconBgColor, size: 20.0),
                ),
                Positioned(
                  top: 26.0,
                  right: 40.0,
                  height: 30.0,
                  width: 30.0,
                  child: Icon(Icons.crop_free,
                      color: _iconBgColor, size: 20.0),
                ),
                Positioned(
                    top: 26.0,
                    right: 10.0,
                    height: 30.0,
                    width: 30.0,
                    child: Icon(Icons.message,
                        color: _iconBgColor, size: 20.0))
              ],
            ),
          ),
        ));
  }
}
