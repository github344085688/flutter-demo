import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCliver extends StatefulWidget {
  double _toolbarHeight;
  double _searchRight;
  double _searchButtom;
  double _opacity;
  double _expandedHeight;
  double _appBarOpacity;
  int _bgBarOpacity;

  AppBarCliver({
    Key key,
    double initBarHeight: 75,
    double setBarHeight: 41,
    double toolbarHeight: 75,
    double initSsearchRight: 85,
    double searchRight: 0,
    double searchButtom: 4.0,
    double opacity: 1,
    double expandedHeight: 78,
    double appBarOpacity: 1,
  })  : _toolbarHeight = toolbarHeight,
        _searchRight = searchRight,
        _searchButtom = searchButtom,
        _opacity = opacity,
        _expandedHeight = expandedHeight,
        _appBarOpacity = appBarOpacity,
        _bgBarOpacity = searchRight.toInt(),
        super(key: key);

  AppBarCliver namedControl(
      {Key key,
      double opinitBarHeight,
      double opsetBarHeight,
      double optoolbarHeight,
      double opinitSsearchRight,
      double opsearchRight,
      double opsearchButtom,
      double opopacity,
      double opexpandedHeight}) {
    _toolbarHeight = optoolbarHeight;
    _searchRight = opsearchRight;
    _searchButtom = opsearchButtom;
    _opacity = opopacity;
    _expandedHeight = opexpandedHeight;
    print(optoolbarHeight);
  }

  @override
  _AppBarCliver createState() => _AppBarCliver();
}

class _AppBarCliver extends State<AppBarCliver> {
  @override
  Widget build(BuildContext context) => SliverAppBar(
        // backgroundColor: Color.fromRGBO(1, 40, 49, widget._appBarOpacity),
        // backgroundColor: Colors.greenAccent,
        floating: false,
        brightness:
            widget._toolbarHeight > 50 ? Brightness.dark : Brightness.light,
        snap: false,
        pinned: true,
        expandedHeight: widget._expandedHeight,
        flexibleSpace: Opacity(
            opacity: widget._appBarOpacity,
            child: Container(
                decoration: BoxDecoration(
                  //背景装饰
                  gradient: LinearGradient(
                      //背景径向渐变
                      colors: [
                        Color.fromRGBO(
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 1.18 / 100),
                        Color.fromRGBO(
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 3,
                            widget._bgBarOpacity * 1.18 / 100)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                height: double.infinity)),
        /*   FlexibleSpaceBar(
          // backgroun:Colors.deepOrange,
          background: Image.asset(
            'assets/images/material_design_3.png',
            fit: BoxFit.cover,
          ),
          collapseMode: CollapseMode.parallax,
          centerTitle: false,
          stretchModes: [StretchMode.fadeTitle],
        ),*/
        toolbarHeight: widget._toolbarHeight,
        title: Opacity(
          opacity: widget._appBarOpacity,
          child: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            height: widget._toolbarHeight,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned(
                  top: 4.0,
                  left: 0,
                  height: 40.0,
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
                  bottom: widget._searchButtom,
                  child: Container(
                      height: 28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color(0xFF012F3D),
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
                                color: Theme.of(context).dividerColor),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text("${widget._toolbarHeight}",
                                style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontSize: 18.0)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.camera_alt,
                                size: 20.0,
                                color: Theme.of(context).dividerColor),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  top: 0.0,
                  right: 40.0,
                  child: Container(
                    width: 35,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.crop_free,
                          color: Theme.of(context).dividerColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 5.0,
                  child: Container(
                    width: 35,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.message,
                          color: Theme.of(context).dividerColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
