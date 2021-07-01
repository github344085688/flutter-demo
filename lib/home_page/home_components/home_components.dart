import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_demo/home_page/list/allList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/components/timersSetting.dart';

import 'dart:math';
import 'dart:typed_data';

class HomeComponents {
  BuildContext _context;

  svgPictureAsset({String url, Color svgColor}) {
    return new SvgPicture.asset(
      url,
      color: svgColor,
    );
  }

  HomeComponents(BuildContext context) {
    _context = context;
  }

  Widget navGroupMenuWidget() {
    return Wrap(
        spacing: 12.0, // 主轴(水平)方向间距
        runSpacing: -11.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //
        children: girdMenuWidgetData.map((e) => _navGroupWidget(e)).toList());
  }

  Widget _navGroupWidget(Map data) {
    return Container(
      padding: EdgeInsets.all(8),
      child: CircleAvatar(
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
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Color(0xff2f363e),
                blurRadius: 1.6,
                spreadRadius: -0.5,
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: ComponentStyle.LINE_COLOR,
            ),
            child: Icon(
              data['icon'],
              size: 20.0,
              color: Theme.of(_context).dividerColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget svgbannerBg(String svgUrl, Color color) {
    return SvgPicture.asset(
      svgUrl,
      color: color,
    );
  }

  Widget ipsumGroup(Map gou) {
    return Container(
      width: double.infinity,
      height: 90.0,
      padding: EdgeInsets.only(
          top: ScreenApdar.setHeight(5.0),
          bottom: ScreenApdar.setHeight(5.0),
          left: ScreenApdar.setWidth(10.0),
          right: ScreenApdar.setWidth(10.0)),
      child: Stack(
        children: [
          Positioned(
            top: 74.0,
            left: 94.0,
            child: svgbannerBg(
                "assets/images/banner_bg_bt.svg", gou['topiconColor']),
          ),
          Positioned(
            top: 4.0,
            bottom: 5.0,
            left: 0,
            right: 0,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: gou['containerColor'],
                image: DecorationImage(
                    image: AssetImage(gou['bgUrl']), fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.5, 1),
                    color: ComponentStyle.MALL_FOCUS_BG,
                    blurRadius: 1,
                    spreadRadius: -0.5,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            width: 100.0,
            height: 80.0,
            child:
                svgbannerBg("assets/images/banner_bg.svg", gou['bgiconColor']),
          ),
          Positioned(
            top: 31.0,
            left: 10,
            child: Text(
              gou['title'],
              style: TextStyle(
                shadows: [
                  BoxShadow(
                    offset: Offset(-1.5, 2),
                    color: ComponentStyle.INDICATOR_COLOR,
                    blurRadius: 5,
                    spreadRadius: -1,
                  )
                ],
                color: ComponentStyle.MAIN_COLOR,
                fontSize: 40.0,
              ),
            ),
          ),
          Positioned(
              width: 65.0,
              height: 2.0,
              top: 68.0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-3, 2),
                      color: ComponentStyle.INDICATOR_COLOR,
                      blurRadius: 0.6,
                      spreadRadius: -2,
                    )
                  ],
                  color: ComponentStyle.DIVIDER_COLOR,
                ),
              )),
          Positioned(
            top: 10.0,
            right: 10,
            child: Text(
              gou['lable'],
              style: TextStyle(
                color: gou['topiconColor'],
                fontSize: 16.0,
              ),
            ),
          ),
          Positioned(
              top: 30.0,
              bottom: 0,
              left: 120.0,
              right: 10,
              child: Text(
                gou['text'],
                maxLines: 10,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: gou['topiconColor'],
                  fontSize: 12.0,
                ),
              )),
        ],
      ),
    );
  }

  Widget theirCoupons(Map gou) {
    return Container(
      height: 100,
      width: 100,
      transform: Matrix4.rotationZ(pi / 4),
      decoration: BoxDecoration(color: Colors.green),
    );
  }

  Widget svgAsset(String url){
    return svgPictureAsset(url: url);
  }

  Widget companyGroup(Map group) {
    List<Map> _listbanexData = group['listbanexData'];
    return Container(
        height: 90.0,
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: group['bgColor'],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0)),
                ),
                child: group['isSeckill'] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenApdar.setWidth(20.0),
                            height: ScreenApdar.setHeight(25.0),
                            margin: EdgeInsets.only(top: 5.0),
                            child: svgPictureAsset(url: group['img']),
                          ),
                          Container(
                            width: ScreenApdar.setWidth(16.0),
                            child: TimersSetting(),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenApdar.setWidth(13.0),
                            height: ScreenApdar.setHeight(60.0),
                            margin: EdgeInsets.only(top: 10.0),
                            child: svgPictureAsset(url: group['img']),
                          ),
                        ],
                      ),
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: group['moudleColor'],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0)),
                ),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _listbanexData
                        .map((e) => _banexpanded(e))
                        .toList()),
              ),
            ),
          ],
        ));
  }

  Widget _banexpanded(Map listMap) {
    return Container(
        width: ScreenApdar.setWidth(77.0),
        child: Card(
            child: Container(
                height: double.infinity,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.only(
                    left: ScreenApdar.setWidth(0),
                    bottom: ScreenApdar.setWidth(0),
                    right: ScreenApdar.setWidth(0)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    image: DecorationImage(
                        image: AssetImage(listMap['imagUrl']), fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: double.infinity,
                        height: ScreenApdar.setHeight(1),
                        color: ComponentStyle.LINE_COLOR),
                    Container(
                      width: double.infinity,
                      height: ScreenApdar.setHeight(13.0),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: ScreenApdar.setWidth(3),
                          right: ScreenApdar.setWidth(3)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: Color.fromRGBO(44, 52, 65, 0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.up,
                        children: <Widget>[
                          Text('¥ ${listMap['price']}',
                              style: TextStyle(
                                color: ComponentStyle.LINE_COLOR,
                                fontSize: 14.0,
                              )),
                          Text('¥ ${listMap['orPrice']}',
                              style: TextStyle(
                                color: ComponentStyle.DIVIDER_COLOR,
                                fontSize: 8.0,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:ComponentStyle.DIVIDER_COLOR,
                              ))
                        ],
                      ),
                    )
                  ],
                ))));
  }

  List<IntSize> _createSizes(int count) {
    final rnd = Random();
    return List.generate(
        count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
  }

  Widget getStaggeredView(List goodsList) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 4,
      itemCount: goodsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(goodsList[index]["url"]),
                          fit: BoxFit.fill),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(goodsList[index]["name"],
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "￥${goodsList[index]["price"]}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ))
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 4),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }

  Widget getStaggeredView2(List expandStateList) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 4,
      staggeredTileBuilder: (_) => const StaggeredTile.fit(2),
      itemBuilder: (context, index) => _Tile2(expandStateList[index]['img'], 6),
      itemCount: expandStateList.length,
    );
  }

  Widget appBarbg(int swiperChangedIndex) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 220.0,
      child: Container(
        color: Theme.of(_context).primaryColor,
        width: double.infinity,
        height: 220.0,
        child: Stack(
          children: [
            Positioned(
              left: 40.0,
              top: 50.0,
              width: 120.0,
              height: 80.0,
              child: HomeComponents(_context).svgbannerBg(
                  "assets/images/banner-shou.svg",
                  bannerColors[swiperChangedIndex]['fuColor']),
            ),
            Positioned(
              right: 20.0,
              top: 50.0,
              width: 160.0,
              height: 90.0,
              child: HomeComponents(_context).svgbannerBg(
                  "assets/images/banner-shou.svg",
                  bannerColors[swiperChangedIndex]['fuColor']),
            ),
            Positioned(
              left: 60.0,
              top: 0.0,
              width: 250.0,
              height: 180.0,
              child: HomeComponents(_context).svgbannerBg(
                  "assets/images/banner-shou.svg",
                  bannerColors[swiperChangedIndex]['maiColor']),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Image.asset('assets/images/bar_bg.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile2 extends StatelessWidget {
  const _Tile2(this.source, this.index);

  final String source;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(source),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Vincent Van Gogh',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

List<IntSize> _createSizes(int count) {
  final rnd = Random();
  return List.generate(
      count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Height: ${size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StaggeredGrids extends StatelessWidget {
  StaggeredGrids() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 20;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) => _Tile(index, _sizes[index]),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    );
  }
}
