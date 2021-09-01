import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'countdown.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/imgProcessing.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(ScreenApdar.dessignWidth, ScreenApdar.dessignHeight),
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: ComponentStyle.MALL_FOCUS_BG,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: ScreenApdar.setWidth(25.0),
              top: ScreenApdar.setHeight(80.0),
              child: CountdownInit(),
            ),
            Positioned(
              top: ScreenApdar.setHeight(80.0),
              left: 0,
              right: 0,
              child: ImgProcessing.svgPictureAsset(
                  url: 'assets/images/init_logo.svg'),
            ),
            Positioned(
              bottom: ScreenApdar.setHeight(80.0),
              left: 0,
              right: 0,
              child:Center(
                child:  ImgProcessing.svgPictureAsset(
                    url: 'assets/images/init_icon.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
