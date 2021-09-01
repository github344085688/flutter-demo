import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_demo/servers/json_servers.dart' show asset;
import 'package:flutter_demo/servers/service.dart';
import 'package:flutter_demo/components/screenApdar.dart';

class DetailPage extends StatefulWidget {
  final Map arguments;

  const DetailPage({Key key, Map arguments})
      : this.arguments = arguments,
        super(key: key);

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  var _detail;
  static final List<GlobalKey> _key = List.generate(20, (index) => GlobalKey());

/*
   Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    new NetworkImage('https://i.stack.imgur.com/lkd0a.png')
        .resolve(new ImageConfiguration())
        .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    return completer.future;
  }*/

  Future deteiState() async {
    final setData = await asset.get('assets/json/creads.json');
    final deteiStateList = json.decode(setData);
    var detail;
    deteiStateList.forEach((state) {
      if (state["id"] == widget.arguments['id']) detail = state;
    });

    return detail;
  }

  @override
  void initState() {
    setState(() {
      _detail = deteiState();
    });
    super.initState();
  }


  final List<Widget> _datelsPotos = List.generate( 6,  (index) => Image.asset(
    'assets/images/470$index.jpg',
    key: _key[index],
    fit: BoxFit.fitWidth,
  ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _detail, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              // DYdialog.showLoading(context);
              return Text('Awaiting result...');
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              };
              return _customScrollView(snapshot.data);
              break;
          }
          return Text('Awaiting result...');// unreachable
        },
      ),
      bottomNavigationBar: buildBottomBar()
      /* ,*/
    );
  }

  Widget _customScrollView(Map data) {
    return AsperctRaioImage.asset(
      data['img'],
      builder: (context, snapshot, url) {
        print('width=${snapshot.data.width}');
        print('heiht=${snapshot.data.height / snapshot.data.width}');
        var _imgHPor = snapshot.data.height / snapshot.data.width;
        var _getScreenWidth = ScreenApdar.getScreenWidth();
        print('getScreenWidth=$_getScreenWidth');
        return CustomScrollView(
          // physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverCustomHeaderDelegate(
                  globalKey:_key,
                  title: data['img'],
                  collapsedHeight: ScreenApdar.setWidth(40.0),
                  expandedHeight: _imgHPor * _getScreenWidth,
                  paddingTop: MediaQuery.of(context).padding.top,
                  coverImgUrl: url),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("华为P30原装充电器数据线22.5W超级快充5V4.5A原配耳机5A充电线",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: ScreenApdar.setFontSize(18.0))),
                        ),
                       Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _datelsPotos),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Text('特价'),
                                    Text('￥28',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: ScreenApdar.setFontSize(46)))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('原价'),
                                    Text('￥50',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: ScreenApdar.setFontSize(28),
                                            decoration: TextDecoration.lineThrough))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        //筛选：
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: ScreenApdar.setFontSize(80),
                          child: Row(
                            children: <Widget>[
                              Text('已选', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('115,黑色')
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: ScreenApdar.setHeight(80),
                          child: Row(
                            children: <Widget>[
                              Text('运费', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('免运费')
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        );
      },
    );
  }



  ///创建底部栏
  BottomAppBar buildBottomBar() {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(flex: 3, child: Text("联系客服")),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffff9b00", radix: 16)),
                    Color(int.parse("ffF8CD6A", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(
                    child: Text(
                      "加入购物车",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffFF5252", radix: 16)),
                    Color(int.parse("ffFF0000", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(
                    child: Text(
                      "直接购买",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  final List<GlobalKey> globalKey;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.globalKey,
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  int makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return alpha;
  }

  double _makeStickyOpacity(shrinkOffset) {
    final double alpha = (shrinkOffset / (this.maxExtent - this.minExtent))
        .clamp(0, 1)
        .toDouble();
    return alpha;
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: Image.asset(
            this.coverImgUrl,
            fit: BoxFit.fitWidth,
          )),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: Color.fromARGB(
                  this.makeStickyHeaderBgColor(shrinkOffset), 255, 255, 255),
              child: SafeArea(
                bottom: false,
                child: Container(
                    height: this.collapsedHeight,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            color: Colors.deepPurple,
                            splashColor: Colors.deepPurple,
                            highlightColor: Colors.deepPurple,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: this.makeStickyHeaderTextColor(
                                  shrinkOffset, true),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Opacity(
                            opacity: _makeStickyOpacity(shrinkOffset),
                            child: Flex(direction: Axis.horizontal, children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("商品")]),
                                  onTap: () {
                                    print('商品商品商品商品商品');
                                    Scrollable.ensureVisible(
                                        globalKey[1].currentContext);
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("详情")]),
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                        globalKey[3].currentContext);
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("推荐")]),
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                        globalKey[5].currentContext);
                                  },
                                ),
                              )
                            ]),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: this.makeStickyHeaderTextColor(
                                  shrinkOffset, true),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilmContent extends StatelessWidget {
  final List<GlobalKey> globalKey;
  FilmContent({
    this.globalKey
  });

  final List<Widget> _datelsPotos = List.generate( 7,  (index) => Image.asset(
    'assets/images/470$index.jpg',
    // key: globalKey[index],
    fit: BoxFit.fitWidth,
  ),
   /*   RaisedButton(
    onPressed: () {},
    // color: index % 2 == 0 ? Colors.grey : Colors.white,
    child: Text("Button No # ${index + 1}", key: _key[index]),
  ),*/
  );


  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("华为P30原装充电器数据线22.5W超级快充5V4.5A原配耳机5A充电线",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: ScreenApdar.setFontSize(18.0))),
          ),
          /*  Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad",style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenApdar.setFontSize(18.0)
            )),
          ),*/
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _datelsPotos),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text('特价'),
                      Text('￥28',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenApdar.setFontSize(46)))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('原价'),
                      Text('￥50',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenApdar.setFontSize(28),
                              decoration: TextDecoration.lineThrough))
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选：
          Container(
            margin: EdgeInsets.only(top: 10),
            height: ScreenApdar.setFontSize(80),
            child: Row(
              children: <Widget>[
                Text('已选', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('115,黑色')
              ],
            ),
          ),
          Divider(),
          Container(
            height: ScreenApdar.setHeight(80),
            child: Row(
              children: <Widget>[
                Text('运费', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('免运费')
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
