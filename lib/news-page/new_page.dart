import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/home_page/home_components/home_components.dart'
    show HomeComponents, HeadTabBars;
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_demo/news-page/twolevel_refresh.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<NewPage> {


  SystemUiOverlayStyle _systemUiOverlayStyle = SystemUiOverlayStyle.light;







  Widget _refreshConfiguration() {
    return RefreshConfiguration(
        child:Padding(
            padding:EdgeInsets.only(top:150),
          child: SizedBox(
            width: 250.0,
            height: 24.0,
            child:TwoLevelExample(),
          ),
        ),

         );
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _systemUiOverlayStyle,
        child: Scaffold(
            resizeToAvoidBottomInset: false, body: _refreshConfiguration()));
  }
}
