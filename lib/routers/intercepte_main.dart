import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/provider/provider_date.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/router.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/keys.dart';

import 'package:flutter_demo/my_mine_page/my_mine_page.dart';

import 'package:flutter_demo/home_page/home_page.dart';
final List<Permission> needPermissionList = [
  Permission.location,
  Permission.storage,
  Permission.phone,
  Permission.camera,
];

class IntercepteMain extends StatelessWidget {
  const IntercepteMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [ChangeNotifierProvider.value(value: ProviderDate(1))],
        child: _InitMainState(),
      );
}

class _InitMainState extends StatefulWidget {
  _InitMainState({Key key}) : super(key: key);

  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<_InitMainState>{
  final _globalNavigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void reassemble() {
    super.reassemble();
    _checkPermissions();
  }

  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await needPermissionList.request();
    statuses.forEach((key, value) {
      // print('$key ============--------------------- is $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //只能纵向
      // DeviceOrientation.portraitDown,//只能纵向
    ]);
    var  _navigatorKey = NavigatorKey();
    return MaterialApp(
      navigatorKey: NoomiKeys.navKey,
      title: 'My Main App Flutter',
      theme: ThemeData(
        iconTheme: IconThemeData(color: ComponentStyle.PRIMARY_COLOR),
        primaryColor: ComponentStyle.MAIN_COLOR,
        accentColor: ComponentStyle.DIVIDER_COLOR,
        indicatorColor: ComponentStyle.PRIMARY_COLOR,
        dividerColor: ComponentStyle.ACCENT_COLOR,
        textTheme: TextTheme(bodyText1: TextStyle(color: ComponentStyle.INDICATOR_COLOR)),),
      // routes: _navigatorKey.routes(), //routes优先执行，所以必须注释掉，否则onGenerateRoute方法不会调用
      onGenerateRoute: _navigatorKey.onGenerateRoute,
    /*  navigatorObservers:[
        MyNavigator()
      ],*/
    );
  }
}
