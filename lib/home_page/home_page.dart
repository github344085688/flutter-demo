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
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_demo/servers/json_servers.dart' show asset;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double _initBarHeight = 85;
  double _searchRight = 0;
  double _searchButtom = -12.0;
  double _setBarHeight = 60;
  double _opacity = 1.0;
  double _toolbarHeight = 85;
  double _appBarOpacity = 1;
  double _expandedHeight = 90;
  int currentIndex = 0;
  int _swiperChangedIndex = 0;
  bool _isPhysics = false;
  bool _isScroll = false;
  SystemUiOverlayStyle _systemUiOverlayStyle = SystemUiOverlayStyle.light;

  List _expandStateList = [];

  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController = RefreshController();
  GlobalKey _contentKey = GlobalKey();
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



  void init() async {
    var setData = await asset.get('assets/json/creads.json');
    setState(() {
      _expandStateList = json.decode(setData);
    });
  }

  void _onLoading() async {
    print('_onLoading');
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));
    var getData = await asset.get('assets/json/potos.json');
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted)
      setState(() {
        _expandStateList.addAll(json.decode(getData));
      });
    _refreshController.loadComplete();
  }

  void _fuRefreshController() {
    _refreshController.headerMode.addListener(() {
      if (_refreshController.headerMode.value == RefreshStatus.idle) {
        setState(() {
        });
        Future.delayed(const Duration(milliseconds: 20)).then((value) {
          setState(() {});
        });
      }
    });
  }

  void _onRefresh() async {
    print('_onRefresh');
    setState(() {
      _isPhysics = true;
    });
    await Future.delayed(Duration(milliseconds: 4000));
    _isPhysics = false;
    _refreshController.refreshCompleted();
  }

  void _onTwoLevel() {
    setState(() {
      _appBarOpacity = 0;
    });
  }

  void _onOffsetChange(isBool, distance) {
    if (isBool && distance >= 0) {
      var appBarOpacity = 1 - (distance * 2.8).round() / 100;
      setState(() {
        _appBarOpacity = appBarOpacity > 0 ? appBarOpacity : 0;
        if (_isScroll && distance < 50 ) _scrollController.jumpTo(0.0 - 0.0);
      });
    }
    if(distance > 130) _isScroll = false;
  }

  void _funScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 34) {
        setState(() {
          _toolbarHeight = _setBarHeight;
        });
      }
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          _systemUiOverlayStyle = SystemUiOverlayStyle.light;
          _toolbarHeight = _initBarHeight - _scrollController.offset * 0.715;
          _opacity = (100 - _scrollController.offset * 2.5).round() / 100;
        });
      }
      else if (_scrollController.offset > 30) {
        setState(() {
          _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          _opacity = 0.0;
        });
      }
      if (_toolbarHeight < 85) _isScroll = true;
      if (_toolbarHeight == 85) _isScroll = false;

      // if (_scrollController.offset == 0 && _isRefresh) _appBarOpacity = 1;
    });
  }

  @override
  void initState() {
    init();
    _fuRefreshController();
    _funScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('addPostFrameCallback');
      _refreshController.position.jumpTo(0);
      setState(() {});
    });
    super.initState();
  }



  Widget _getScrollWidget() {
    return Builder(
        builder: (BuildContext context) => RefreshConfiguration.copyAncestor(
              context: context,
              enableScrollWhenTwoLevel: true,
              maxOverScrollExtent: 120,
              enableLoadingWhenFailed: true,
              maxUnderScrollExtent: 100.0,
              footerTriggerDistance: -45.0,
              child: LayoutBuilder(
                builder: (_, c) {
                  return SmartRefresher(
                    key: _contentKey,
                    controller: _refreshController,
                    enableTwoLevel: true,
                    enablePullDown: true,
                    enablePullUp: true,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    onTwoLevel: _onTwoLevel,
                    onOffsetChange: _onOffsetChange,
                    child: _customScrollView(),
                  );
                },
              ),
            ));
  }

  Widget _customScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      physics: _isPhysics
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverPadding(
            padding: EdgeInsets.only(
              top: _initBarHeight,
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

  Widget _refreshConfiguration() {
    return RefreshConfiguration(
        dragSpeedRatio: 0.91,
        enableScrollWhenTwoLevel: true,
        maxOverScrollExtent: 120,
        footerTriggerDistance: -80,
        maxUnderScrollExtent: 60,
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        footerBuilder: () => ClassicFooter(),
        headerBuilder: () => TwoLevelHeader(
              textStyle: TextStyle(color: Colors.white),
              displayAlignment: TwoLevelDisplayAlignment.fromTop,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/secondfloor.jpg"),
                    fit: BoxFit.fitWidth,
                    // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
                    alignment: Alignment.topCenter),
              ),
              twoLevelWidget: TwoLevelWidget(setActivity:(){
                print('wwwwwwwwwwww');
              }),
            ),
        /*    headerBuilder:(BuildContext context)=>,*/

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
            AppBarWidge(
                setBarHeight: _setBarHeight,
                toolbarHeight: _toolbarHeight,
                searchRight: _searchRight,
                searchButtom: _searchButtom,
                opacity: _opacity,
                expandedHeight: _expandedHeight,
                appBarOpacity: _appBarOpacity)
          ],
        ));
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

