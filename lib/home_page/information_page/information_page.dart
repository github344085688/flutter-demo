import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/components/imgProcessing.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key key}) : super(key: key);

  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  bool _isPhysic = true;
  List<Map> _tages = [
    {
      "icon": "assets/images/icom/buzhou.svg",
      "brColor": Colors.green[400],
      "widget":Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("6000", style: TextStyle(
                  color: ComponentStyle.LINE_COLOR,
                  fontSize: 20.0)),
              Text("步"),
            ],
          ),
        Text(" 步数 ",
          style: TextStyle(
              color: ComponentStyle.DIVIDER_COLOR,
              fontSize: 12.0),),
        ]
      ),
    },
    {
      "icon": "assets/images/icom/times.svg",
      "brColor": Colors.pink[400],
      "widget":Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("62", style: TextStyle(
                    color: ComponentStyle.LINE_COLOR,
                    fontSize: 20.0)),
                Text("次/分钟"),
              ],
            ),
            Text(" 静息心率 ",
              style: TextStyle(
                  color: ComponentStyle.DIVIDER_COLOR,
                  fontSize: 12.0),),
          ]
      ),
    },
    {
      "icon": "assets/images/icom/tag04.svg",
      "brColor": Colors.purple[400],
      "widget":Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("7", style: TextStyle(
                    color: ComponentStyle.LINE_COLOR,
                    fontSize: 20.0)),
                Text("小时"),
                Text("56", style: TextStyle(
                    color: ComponentStyle.LINE_COLOR,
                    fontSize: 20.0)),
                Text("分钟"),
              ],
            ),
            Text(" 睡眠时长 ",
              style: TextStyle(
                  color: ComponentStyle.DIVIDER_COLOR,
                  fontSize: 12.0),),
          ]
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: ComponentStyle.INDICATOR_COLOR,
      body: CustomScrollView(
          physics: _isPhysic
              ? NeverScrollableScrollPhysics() //不响应用户的滚动。
              : AlwaysScrollableScrollPhysics(), //始终响应用户的滚动
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.only(
                  top: ScreenApdar.setHeight(ScreenApdar.statusBarHeight()),
                  left: ScreenApdar.setWidth(10.0),
                  right: ScreenApdar.setWidth(10.0),
                  bottom: ScreenApdar.setWidth(20.0),
                ),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Flex(direction: Axis.horizontal, children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Flex(direction: Axis.horizontal, children: [
                          Container(
                            width: ScreenApdar.setWidth(14.0),
                            padding: EdgeInsets.only(
                                right: ScreenApdar.setWidth(2.0)),
                            child: ImgProcessing.svgPictureAsset(
                                url: 'assets/images/icom/worch.svg',
                                svgColor: ComponentStyle.LINE_COLOR),
                          ),
                          Container(
                            child: Text(
                              '已连接',
                              style: TextStyle(
                                  color: ComponentStyle.LINE_COLOR,
                                  fontSize: 12.0),
                            ),
                          ),
                        ]),
                      ),
                      Expanded(
                        flex: 4,
                        child: Flex(direction: Axis.horizontal, children: [
                          Container(
                            width: ScreenApdar.setWidth(10.0),
                            padding: EdgeInsets.only(
                                right: ScreenApdar.setWidth(2.0)),
                            child: ImgProcessing.svgPictureAsset(
                                url: 'assets/images/icom/dianchi.svg',
                                svgColor: ComponentStyle.LINE_COLOR),
                          ),
                          Container(
                            child: Text(
                              '已连接',
                              style: TextStyle(
                                  color: ComponentStyle.LINE_COLOR,
                                  fontSize: 12.0),
                            ),
                          ),
                        ]),
                      ),
                    ]);
                  },
                  childCount: 1,
                ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("卡路里消耗"),
                        Container(
                            margin: EdgeInsets.only(left: 5.0),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: ComponentStyle.LINE_COLOR,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Icon(Icons.arrow_forward_ios_sharp,
                                color: ComponentStyle.INDICATOR_COLOR,
                                size: ScreenApdar.setFontSize(12)))
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 12.0),
                            child: Text(
                              '2360',
                              style: TextStyle(
                                  color: ComponentStyle.LINE_COLOR,
                                  fontSize: ScreenApdar.setFontSize(50)),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 0.0),
                            child: Text(
                              'KCAL',
                              style: TextStyle(
                                  color: ComponentStyle.LINE_COLOR,
                                  fontSize: ScreenApdar.setFontSize(16)),
                            ),
                          ),
                        ]),
                    Container(
                      padding: EdgeInsets.only(
                        top: ScreenApdar.setHeight(ScreenApdar.statusBarHeight()),
                        left: ScreenApdar.setWidth(10.0),
                        right: ScreenApdar.setWidth(10.0),
                      ),
                      child: Flex(
                          direction: Axis.horizontal,
                          children: _tages.map<Widget>((e) => _BuildTages(e)).toList()
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            )),

          ]),
    );
  }


  Widget _BuildTages(Map item ){
   return Expanded(
      flex: 1,
      child: Flex(direction: Axis.vertical, children: [
        Container(
          width: ScreenApdar.setWidth(70.0),
          height: ScreenApdar.setWidth(70.0),
          decoration:BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              // color: Color(0xFF012F3D),
              border: Border.all(
                  color: item['brColor'],
                  width: 3.0,
                  style: BorderStyle.solid)),
          padding: EdgeInsets.all(10.0),
          child: ImgProcessing.svgPictureAsset(
              url: item['icon'],
              svgColor: item['brColor']),
        ),
        Container(
          margin: EdgeInsets.only(top:ScreenApdar.setHeight(5.0)),
          child: item['widget'],
        ),
      ]),
    );
  }
}
