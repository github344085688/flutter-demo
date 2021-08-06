import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/routers/navigator_admin.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/routers/router.dart';
import 'package:flutter/services.dart';

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
      if(changedIndex==0&&_privatecurrentIndex!=0) _currentIndex = 0;
      // if(changedIndex==0&&_privatecurrentIndex!=0) _widgetPage = IndexPage();
      // _currentIndex = changedIndex;
      _privatecurrentIndex = changedIndex;
      NavigationAdmin(context).BottomNavigation(changedIndex);
      if (_privatecurrentIndex == 3) {
        _privatecurrentIndex = 0;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    final _indexNavigatorKey = new NavigatorKey(navigatorKey:widget.navigatorKey,indexNavigatorKey:_navigatorKey);
    return  WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKey.currentState.maybePop();
         /* final isprFirstRouteInCurrentTab =
          !await widget.navigatorKey.currentState.maybePop();*/
          print('11111111111111111111${isFirstRouteInCurrentTab}');
          // print('11111111111111111111prprprpr${isprFirstRouteInCurrentTab}');
          // return false;
       /*
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.red) {
            _selectTab(TabItem.red);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;*/
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
       Navigator(
         key: _navigatorKey,
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
