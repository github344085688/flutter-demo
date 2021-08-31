/*
 * @discripe: 载入APP启动页
 */
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'countdown.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  
  @override
  _SplashPageState createState() => _SplashPageState();
}
  
class _SplashPageState extends State<SplashPage>{
  // SharedPreferences prefs;
  
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: ScreenApdar.setWidth(25.0),
              top: ScreenApdar.setHeight(25.0),
              child: CountdownInit(),
            ),
            SizedBox(
              width: ScreenApdar.setWidth(375.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/init_logo.webp',
                    width: ScreenApdar.setWidth(300.0),
                  ),
                  Padding(padding: EdgeInsets.only(top: ScreenApdar.setWidth(70.0)),),
                  Image.asset(
                    'assets/images/init_icon.png',
                    width: ScreenApdar.setWidth(90.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
