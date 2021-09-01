import 'package:flutter/material.dart';

// import 'package:flutter_demo/home_page/home_page5.dart';
import 'package:flutter_demo/home_page/home_page.dart';
import 'package:flutter_demo/my_mine_page/my_mine_page.dart';
import 'package:flutter_demo/news-page/new_page.dart';
import 'package:flutter_demo/home_page/information_page/information_page.dart';
import 'package:flutter_demo/home_page/index_page/index_page.dart';
import 'package:flutter_demo/home_page/information_page/information_page.dart';
import 'package:flutter_demo/home_page/index_page/detail_page.dart';
import 'package:flutter_demo/home_page/index_page/detail_page.dart';
import 'package:flutter_demo/components/Search.dart';
import 'package:flutter_demo/home_page/CheckOut.dart';
import 'package:flutter_demo/components/home_search_page.dart';
import 'package:flutter_demo/home_page/home_init/index.dart';
class NavigatorKey {

  NavigatorKey();

  routes() => {
        // '/': (context) => NewPage(),
        '/': (context) => SplashPage(),
        '/index': (context) => HomePage(),
        '/detail': (context, {arguments}) => DetailPage(arguments: arguments),
        '/myMine': (context) => MyMinePage(),
        // '/myMine': (context) => MyMinePage(),
        '/report': (context) => InformationPage(),
    // '/search': (context) => CheckOutPage(),
    '/search': (context) => SearchPage(),
    // '/search': (context) => MySearchDelegate(),
    // '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
        // '/classification': (context) => Faxian(),

        // '/new': (context) => NewPage(),
      };

  homeRoutes() => {
        '/': (context) => IndexPage(),
        '/detail': (context, {arguments}) => DetailPage(arguments: arguments),
        '/page2': (context) => InformationPage(),
      };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
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
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  }

  Route<dynamic> indexNavigatorRouters(RouteSettings settings) {
    final routes = this.homeRoutes();
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments),
            fullscreenDialog:false//是否全屏打开新的路由
        );
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  }
}



///导航栈的变化监听
class MyNavigator extends NavigatorObserver{

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    var previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    }else {
      previousName = previousRoute.settings.name;
    }
    print('YM----->NavObserverDidPop--Current:' + route.settings.name + '  Previous:' + previousName);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);

    var previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    }else {
      previousName = previousRoute.settings.name;
    }
    print('YM-------NavObserverDidPush-Current:' + route.settings.name + '  Previous:' + previousName);
    print(route.settings.name);
    print(route.settings.arguments);

  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute,oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
  }
}
