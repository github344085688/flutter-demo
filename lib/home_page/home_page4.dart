import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_demo/home_page/list/allList.dart';
import 'package:flutter_demo/home_page/head_tab_bar.dart';
import 'package:flutter_demo/components/swiper_widget.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/home_page/two_level_widget.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/routers/navigator_admin.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/home_page/home_components/home_components.dart'
    show HomeComponents, HeadTabBars;
import 'package:flutter_demo/servers/json_servers.dart' show asset;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_demo/components/app_bar-cliver.dart';
class OrderModel {
  final String img;
  final Widget des;
  final Widget price;
  final Widget want;
  final Widget username;

  const OrderModel({
    this.img,
    this.des,
    this.price,
    this.want,
    this.username,
  });

}


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double _initBarHeight = 75;
  double _setBarHeight = 41;
  double _toolbarHeight = 75;
  double _initSsearchRight = 85;
  double _searchRight = 0;
  double _searchButtom = 4.0;
  double _opacity = 1.0;
  double _expandedHeight = 78;
  double _appBarOpacity = 1;

  bool _isRefresh = true;

  int currentIndex = 0;
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController1 = RefreshController();
  RefreshController _refreshController2 = RefreshController();
  List _expandStateList = [];

  _currentIndex(BuildContext context, int changedIndex) {
    setState(() {
      currentIndex = changedIndex;
      NavigationAdmin(context).BottomNavigation(changedIndex);
      if (currentIndex == 3) {
        currentIndex = 0;
      }
    });
  }

  _swiperChanged(index) {
    setState(() {
      // _swiperChangedIndex = index;
    });
  }

  void _onRefresh() async {
    print('_onRefresh');
    setState(() {
      _isRefresh = false;
    });
    await Future.delayed(Duration(milliseconds: 2000));
    _refreshController1.refreshCompleted();
  }

  void _onLoading() async {
    print('_onLoading');
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));
    var getData = await asset.get('assets/json/potos.json');
    setState(() {
      _expandStateList.addAll(json.decode(getData));
    });

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if (mounted) setState(() {});
    _refreshController1.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController1.dispose();
    super.dispose();
  }

  void init() async {
    var setData = await asset.get('assets/json/creads.json');
    setState(() {
      _expandStateList = json.decode(setData);
      print(_expandStateList);
    });
  }

  void _funRefreshControl() {
    _refreshController1.headerMode.addListener(() {
      if (_refreshController.headerMode.value == RefreshStatus.idle) {
        setState(() {
          // _appBarOpacity = 1;
          _isRefresh = true;
        });
        Future.delayed(const Duration(milliseconds: 20)).then((value) {
          // _enablePullDown = false;
          setState(() {});
        });
      }
    });
  }

  void _funScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          _searchRight = _scrollController.offset * 2.5;
          _toolbarHeight = _initBarHeight - _scrollController.offset;
          _opacity = (100 - _scrollController.offset * 2.5).round() / 100;
        });
      } else if (_scrollController.offset > 30) {
        setState(() {
          _searchRight = _initSsearchRight;
          _opacity = 0.0;
          _toolbarHeight = _setBarHeight;
        });
      }
      if (_scrollController.offset < 0) {
        var appBarOpacity = 1 + (_scrollController.offset * 2.8).round() / 100;
        if (appBarOpacity > 0 && _isRefresh)
          setState(() {
            _appBarOpacity = appBarOpacity;
          });
      }
      if (_scrollController.offset == 0 && _isRefresh) _appBarOpacity = 1;
    });
  }

  @override
  void initState() {
    init();
    _funRefreshControl();
    _funScrollController();
    super.initState();
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  Widget _scrollWidget() {
    return Builder(
        builder: (BuildContext context) => RefreshConfiguration.copyAncestor(
          context: context,
          enableScrollWhenTwoLevel: true,
          maxOverScrollExtent: 120,
          child: LayoutBuilder(
            builder: (_, c) {
              return SmartRefresher(
                header: TwoLevelHeader(
                  textStyle:
                  TextStyle(color: Theme.of(context).dividerColor),
                  displayAlignment: TwoLevelDisplayAlignment.fromTop,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/secondfloor.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                  ),
                  twoLevelWidget: TwoLevelWidget(),
                ),
                controller: _refreshController1,
                enableTwoLevel: true,
                enablePullDown: true,
                enablePullUp: true,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                onTwoLevel: () {},
                child: _customScrollView(),
              );
            },
          ),
        ));
  }

  Widget _customScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        AppBarCliver(
            initBarHeight: _initBarHeight,
            setBarHeight: _setBarHeight,
            toolbarHeight: _toolbarHeight,
            initSsearchRight: _initSsearchRight,
            searchRight: _searchRight,
            searchButtom: _searchButtom,
            opacity: _opacity,
            expandedHeight: _expandedHeight,
            appBarOpacity: _appBarOpacity),
        SliverPadding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return HeadTabBar();
                  },
                  childCount: 1,
                ))),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: [
                    SwiperWidget(
                        indexChanged: (currentIndex) =>
                            _swiperChanged(currentIndex)),
                    HomeComponents(context).navGroupMenuWidget(),
                    HomeComponents(context).companyGroup(),
                    Column(
                      children: goulpkuData
                          .map((e) => HomeComponents(context).ipsumGroup(e))
                          .toList(),
                    ),
                  ],
                );
              },
              childCount: 1,
            )),
        HomeComponents(context).getStaggeredView2(_expandStateList),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return RefreshConfiguration(
        child: Scaffold(
          body: _scrollWidget(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionBut(),
          ),
          bottomNavigationBar: BottomNavigationView(
              currentIndex: currentIndex,
              setActivity: (currentIndex) => _currentIndex(context, currentIndex)),
          extendBody: true,
        ));
  }
}
