import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/home_page5.dart';
import 'package:flutter_demo/home_page/home_page.dart';
import 'package:flutter_demo/faxian_page/faxian.dart';
import 'package:flutter_demo/my_mine_page/my_mine_page.dart';
import 'package:flutter_demo/news-page/new_page.dart';
import 'package:flutter_demo/faxian_page/faxian.dart';
import 'package:flutter_demo/main_page/main_layout.dart';
import 'package:flutter_demo/useStage/twolevel_refresh.dart';

final routes = {
  // '/': (context) => NewPage(),
  '/': (context) => HomePage(),
  // '/classification': (context) => Faxian(),
  '/classification': (context) => HomePage5(),
  '/myMine': (context) => MyMinePage(),
  // '/new': (context) => TwoLevelExample(),
  '/new': (context) => NewPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
