import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_demo/components/page_indicator.dart';
import 'package:flutter_demo/servers/json_servers.dart' show asset;
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/imgProcessing.dart';
import 'package:flutter_demo/components/screenApdar.dart';
class SwiperTagesWidget extends StatefulWidget {
  final _indexChanged;

  const SwiperTagesWidget({Key key, dynamic indexChanged})
      : _indexChanged = indexChanged,
        super(key: key);

  @override
  _SwiperTagesWidget createState() => _SwiperTagesWidget();
}

class _SwiperTagesWidget extends State<SwiperTagesWidget> {
  List _tages = new List();

  @override
  void initState() {
    init();
  }

  void init() async {
    var tages = await asset.get('assets/json/tages.json');
    setState(() {
      var data = json.decode(tages);
      _tages.add(data.sublist(0, 10).toList());
      _tages.add(data.sublist(10, 20).toList());
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        height: ScreenApdar.setHeight(120),
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(),
        child: Swiper(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          autoplay: false,
          viewportFraction: 1,
          scale: 1,
          customLayoutOption:
              new CustomLayoutOption(startIndex: -1, stateCount: 3)
                  .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
            new Offset(-370.0, -40.0),
            new Offset(0.0, 0.0),
            new Offset(370.0, -40.0)
          ]),
          pagination: new SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: new SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                return new PageIndicator(
                  layout: PageIndicatorLayout.WARM,
                  size: 6.0,
                  space: 4.0,
                  count: 2,
                  color: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).dividerColor,
                  controller: config.pageController,
                );
              })),
          itemBuilder: (BuildContext context, int index) {
            if (_tages.length > 0) {
              return Container(
                  child: Wrap(
                      spacing: 6.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.center, //
                      children: _tages[index]
                          .map<Widget>((e) => _navGroupWidget(context, e))
                          .toList()));
            }
            return null;
          },
        ),
      );

  Widget _navGroupWidget(BuildContext _context, Map data) {
    return Container(
      width:ScreenApdar.setWidth(60),
      // padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child:
      Column(
        children: [
          CircleAvatar(
            backgroundColor: ComponentStyle.TITLE_TEXT_COLOR,
            child: Container(
              height: 34.0,
              width: 34.0,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                gradient: RadialGradient(colors: [
                  ComponentStyle.MALL_FOCUS_BG,
                  ComponentStyle.DIVIDER_COLOR
                ], center: Alignment.topLeft, radius: 20),
              ),
              child: ImgProcessing.svgPictureAsset(
                  url: 'assets/images/${data["icon"]}'),
            ),
          ),
          Text(
            '${data["title"]}',
            style:
                TextStyle(color: ComponentStyle.MALL_FOCUS_BG, fontSize: 12.0),
          )
        ],
      ),
    );
  }

  dispose() {
    // animationController.dispose();
    super.dispose();
  }
}
