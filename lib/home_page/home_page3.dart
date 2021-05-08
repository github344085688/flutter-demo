import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_demo/home_page/list/allList.dart';
import 'package:flutter_demo/components/app_bar_widge.dart';
import 'package:flutter_demo/home_page/head_tab_bar.dart';
import 'package:flutter_demo/components/swiper_widget.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/home_page/two_level_widget.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/routers/navigator_admin.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/home_page/home_components/home_components.dart'
    show HomeComponents, HeadTabBars;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double _initSsearchRight = 95;
  double _searchRight = 0;
  double _searchButtom = -12.0;
  double _opacity = 1.0;
  double _barHeight = 45;
  double _bgOpacity = 0;
  double _appBarOpacity = 1;
  int currentIndex = 0;
  int _swiperChangedIndex = 0;
  bool _isRefresh = true;
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController1 = RefreshController();
  RefreshController _refreshController2 = RefreshController();

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
      _swiperChangedIndex = index;
    });
  }

  void _onRefresh() async {
    print('_onRefresh');
    setState(() {
      _appBarOpacity = 0;
      _isRefresh = false;
    });
    await Future.delayed(Duration(milliseconds: 2000));
    _refreshController1.refreshCompleted();
  }

  void _onLoading() async {
    print('_onLoading');
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController1.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _refreshController1.headerMode.addListener(() {
      // print(_refreshController.headerMode.offset);
      print(_refreshController.headerMode);
        if (_refreshController.headerMode.value == RefreshStatus.idle) {
          setState(() {
            _appBarOpacity = 1;
            _isRefresh = true;
          });
        Future.delayed(const Duration(milliseconds: 20)).then((value) {
          // _enablePullDown = false;
          setState(() {});
        });
      }
    });
    /*   _refreshController1.headerMode.addListener(() {
      print('_refreshController1');
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('addPostFrameCallback');
      _refreshController1.position.jumpTo(0);
      setState(() {});
    });*/
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          _searchRight = _scrollController.offset * 2.8;
          _searchButtom = -12 + _scrollController.offset * 0.8;
          _opacity = (100 - _scrollController.offset * 2.5).round() / 100;
          _bgOpacity = (0 + _scrollController.offset * 2.8).round() / 100;
        });
      } else if (_scrollController.offset > 30) {
        setState(() {
          _searchRight = _initSsearchRight;
          _opacity = 0.0;
          _bgOpacity = 1.0;
        });
      }
        if (_scrollController.offset < 0) {
        var appBarOpacity = 1 + (_scrollController.offset * 2.5).round() / 100;
        if (appBarOpacity > 0)
          setState(() {
            _appBarOpacity = appBarOpacity;
          });
      }
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget _getScrollWidget() {
    return Builder(
        builder: (BuildContext context) => RefreshConfiguration.copyAncestor(
              context: context,
              enableScrollWhenTwoLevel: true,
              maxOverScrollExtent: 120,
              child: LayoutBuilder(
                builder: (_, c) {
                  return SmartRefresher(
                    header: TwoLevelHeader(
                      textStyle: TextStyle(color: Colors.white),
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
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              height: 80,
              color: Color(0x00000000),
            );
          }, childCount: 1),
        ),
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
        SliverStaggeredGrid.countBuilder(
          crossAxisCount: 4,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.green,
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return RefreshConfiguration(
        child: Stack(
      children: [
        HomeComponents(context).appBarbg(_swiperChangedIndex),
        Scaffold(
          backgroundColor: Color(0x00000000),
          body: _getScrollWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionBut(),
          ),
          bottomNavigationBar: BottomNavigationView(
              currentIndex: currentIndex,
              setActivity: (currentIndex) =>
                  _currentIndex(context, currentIndex)),
          extendBody: true,
        ),
       /* AppBarWidge(
            searchRight: _searchRight,
            searchButtom: _searchButtom,
            opacity: _opacity,
            barHeight: _barHeight,
            statusBarHeight: ScreenApdar.statusBarHeight(),
            bgOpacity: _bgOpacity,
            appBarOpacity: _appBarOpacity)*/
      ],
    ));
  }
}
