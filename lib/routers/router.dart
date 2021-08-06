import 'package:flutter/material.dart';

// import 'package:flutter_demo/home_page/home_page5.dart';
import 'package:flutter_demo/home_page/home_page.dart';
import 'package:flutter_demo/faxian_page/faxian.dart';
import 'package:flutter_demo/my_mine_page/my_mine_page.dart';
import 'package:flutter_demo/news-page/new_page.dart';
import 'package:flutter_demo/faxian_page/faxian.dart';
import 'package:flutter_demo/main_page/main_layout.dart';
import 'package:flutter_demo/useStage/twolevel_refresh.dart';
import 'package:flutter_demo/home_page/information_page/information_page.dart';
import 'package:flutter_demo/home_page/index_page/index_page.dart';
import 'package:flutter_demo/home_page/information_page/information_page.dart';

class NavigatorKey {
  GlobalKey<NavigatorState> _navigatorKey;
  GlobalKey<NavigatorState> _indexNavigatorKey;


  NavigatorKey({GlobalKey<NavigatorState> navigatorKey, GlobalKey<NavigatorState> indexNavigatorKey}) :
        _navigatorKey = navigatorKey,
        _indexNavigatorKey = indexNavigatorKey;

  routes() => {
        // '/': (context) => NewPage(),
        '/': (context) => HomePage(navigatorKey: _navigatorKey),
        '/report': (context) => InformationPage(),
        // '/classification': (context) => Faxian(),
        '/classification': (context) => Faxian(),
        '/myMine': (context) => MyMinePage(),
        '/new': (context) => TwoLevelExample(),
        // '/new': (context) => NewPage(),
      };


  homeRoutes() => {
        '/': (context) =>
            IndexPage(navigatorKey: _navigatorKey,homeNavigatorKey:_indexNavigatorKey),
        '/page2': (context) => InformationPage(),
      };

  Route<dynamic> onGenerateRoute(RouteSettings settings){
    final String name = settings.name;
    final routes = this.routes();
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
  }

  Route<dynamic> indexNavigatorRouters(RouteSettings settings) {
    final routes = this.homeRoutes();
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context));
    return route;
  }

}


