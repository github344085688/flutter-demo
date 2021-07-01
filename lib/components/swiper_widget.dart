import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_demo/components/page_indicator.dart';

class SwiperWidget extends StatefulWidget {
  final _indexChanged;
  const SwiperWidget({Key key, dynamic indexChanged}) :_indexChanged = indexChanged, super(key: key);

  @override
  _SwiperWidget createState() => _SwiperWidget();
}

class _SwiperWidget extends State<SwiperWidget> {
  List<Map> imageList = [
    {"url": "assets/images/5.jpg"},
    {"url": "assets/images/6.jpg"},
    {"url": "assets/images/7.jpg"},
    {"url": "assets/images/8.jpg"},
    {"url": "assets/images/9.jpg"}
  ];

  @override
  Widget build(BuildContext context) => Container(
        height: 150,
        decoration: BoxDecoration(
        ),
        child: Swiper(
          itemCount: imageList.length,
          scrollDirection: Axis.horizontal,
          autoplay: true,
          viewportFraction: 1,
          scale: 1,
          autoplayDelay: 10000,
          onIndexChanged:(index)=>{
            widget._indexChanged(index)
          },
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
                      space: 8.0,
                      count: imageList.length,
                      color:Theme.of(context).primaryColor,
                      activeColor:Theme.of(context).dividerColor,
                      controller: config.pageController,
                    );
                  })),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 7.0,right: 7.0,top:5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                      image: AssetImage(
                        imageList[index]["url"],
                      ),
                      fit: BoxFit.cover)),
            );
          },
        ),
      );
  dispose() {
    // animationController.dispose();
    super.dispose();
  }
}
