import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/provider/provider_date.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/router.dart';
import 'package:flutter_demo/style/style.dart';

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

class _MyMainAppState extends State<_InitMainState> {
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
    return MaterialApp(
      initialRoute: '/',
      title: 'My Main App Flutter',
      theme: ThemeData.light().copyWith(
        iconTheme: IconThemeData(color: ComponentStyle.PRIMARY_COLOR),
        primaryColor: ComponentStyle.MAIN_COLOR,
        accentColor: ComponentStyle.DIVIDER_COLOR,
        indicatorColor: ComponentStyle.PRIMARY_COLOR,
        dividerColor: ComponentStyle.ACCENT_COLOR,
        scaffoldBackgroundColor: ComponentStyle.LINE_COLOR,
        textTheme: TextTheme(bodyText1: TextStyle(color: ComponentStyle.INDICATOR_COLOR)),
      ),
      routes: routes,
      // home: MainLayout(),
      // Navigator.defaultRouteName: (context) => homeRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
