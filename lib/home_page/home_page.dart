import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/home_page/bottom_navigation_view.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/routers/router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/keys.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_demo/my_mine_page/my_mine_page.dart';
class HomePage extends StatefulWidget {
  final navigatorKey;
  const HomePage({Key key,  this.navigatorKey}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}


class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  int _privatecurrentIndex = 0;
  int _currentIndex = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  _conterollercurrentIndex(BuildContext context, int changedIndex) {
    print(changedIndex);

    // if(changedIndex==0&&_privatecurrentIndex!=0) _widgetPage = IndexPage();
    setState(() {

      if (changedIndex == 4 && _privatecurrentIndex != 4) {
        _currentIndex = 1;
        // Navigator.pushNamed(context, '/myMine');
       /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.root](context),
          ),
        );*/
      }
      // if(changedIndex==4&&_privatecurrentIndex!=4) _widgetPage =  InformationPage();
      if (changedIndex == 0 && _privatecurrentIndex != 0) _currentIndex = 0;
      // if(changedIndex==0&&_privatecurrentIndex!=0) _widgetPage = IndexPage();
      // _currentIndex = changedIndex;
      _privatecurrentIndex = changedIndex;
      if (_privatecurrentIndex == 3) {
        _privatecurrentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    final _indexNavigatorKey = new NavigatorKey();
    bool isWillPop = false;
    return  WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await NoomiKeys.homeKey.currentState.maybePop();
          print(isFirstRouteInCurrentTab);
          if(isWillPop) return true;
          if (isFirstRouteInCurrentTab) {
            Fluttertoast.showToast(msg: '再按一次退出');
            isWillPop = isFirstRouteInCurrentTab;
            return false;
          }
          return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
       Navigator(
         key: NoomiKeys.homeKey,
         // reportsRouteUpdateToEngine: true,
         onGenerateRoute:_indexNavigatorKey.indexNavigatorRouters,
      ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionBut(
              currentIndex: _privatecurrentIndex,
              setActivity: (currentIndex) =>
                  _conterollercurrentIndex(context, currentIndex)
          ),
        ),
        bottomNavigationBar: BottomNavigationView(
            currentIndex: _privatecurrentIndex,
            setActivity: (currentIndex) =>
                _conterollercurrentIndex(context, currentIndex)),
        extendBody: true,
      )
    );

  }
}
