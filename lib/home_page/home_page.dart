import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_demo/home_page/list/allList.dart';
import 'package:flutter_demo/components/app_bar_widge.dart';
import 'package:flutter_demo/style/style.dart';
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

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  double _initBarHeight = 85;
  double _searchRight = 0;
  double _searchButtom = -12.0;
  double _setBarHeight = 57.9;
  double _opacity = 1.0;
  double _toolbarHeight = 85;
  double _appBarOpacity = 1;
  double _expandedHeight = 90;
  int currentIndex = 0;
  int _swiperChangedIndex = 0;
  bool _isPhysics = false;
  bool _isScroll = false;
  SystemUiOverlayStyle _systemUiOverlayStyle = SystemUiOverlayStyle.dark;

  List _expandStateList = [];

  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController = RefreshController();
  GlobalKey _contentKey = GlobalKey();

  List _bannerColors = [
    Color.fromRGBO(3, 21, 64, 1),
    Color.fromRGBO(246, 131, 200, 1),
    Color.fromRGBO(131, 236, 238, 1),
    Color.fromRGBO(254, 168, 187, 1),
    Color.fromRGBO(103, 111, 209, 1),
  ];
  List<Map> moudles = [
    {
      'img': "assets/images/bannerTitle.svg",
      'bgColor': ComponentStyle.MALL_FOCUS_BG,
      'moudleColor': ComponentStyle.DIVIDER_COLOR,
      'listbanexData': listbanexData,
      'isSeckill': 'true'
    },
    {
      'img': "assets/images/bannerTitle2.svg",
      'bgColor': ComponentStyle.PRIMARY_COLOR,
      'moudleColor': ComponentStyle.MAIN_COLOR,
      'listbanexData': listbanexData,
    }
  ];

  int _recordwiperSIndex = 0;
  AnimationController animationController;
  Animation<Color> color;

  _initAnimation(
    Color _beginColor,
    Color _endColor,
  ) {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    color = ColorTween(
      begin: _beginColor,
      end: _endColor,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
  }

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

      if (index == 0) {
        _initAnimation(
            _bannerColors[_bannerColors.length - 1], _bannerColors[index]);
        _recordwiperSIndex = index;
        return;
      }
      if (index > _recordwiperSIndex) {
        _initAnimation(_bannerColors[index - 1], _bannerColors[index]);
      } else {
        _initAnimation(_bannerColors[index + 1], _bannerColors[index]);
      }
      _recordwiperSIndex = index;
    });
  }

  void init() async {
    var setData = await asset.get('assets/json/creads.json');
    setState(() {
      _expandStateList = json.decode(setData);
    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var getData = await asset.get('assets/json/potos.json');
    if (mounted)
      setState(() {
        _expandStateList.addAll(json.decode(getData));
      });
    _refreshController.loadComplete();
  }

  void _fuRefreshController() {
    _refreshController.headerMode.addListener(() {
      if (_refreshController.headerMode.value == RefreshStatus.idle) {
        setState(() {});
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
        if (_isScroll && distance < 50) _scrollController.jumpTo(0.0 - 0.0);
      });
    }
    if (distance > 130) _isScroll = false;
  }

  void _funScrollController() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset >= 0 && _scrollController.offset < 19) {
        setState(() {
          _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        });
      }
      if (_scrollController.offset >= 0 && _scrollController.offset > 19) {
        _systemUiOverlayStyle = SystemUiOverlayStyle.light;
      }
      if (_scrollController.offset > 34) {
        setState(() {
          _toolbarHeight = _setBarHeight;
        });
      }
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          // _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          _toolbarHeight = _initBarHeight - _scrollController.offset * 0.8;
          // print(_toolbarHeight);
          _opacity = (100 - _scrollController.offset * 2.5).round() / 100;
        });
      } else if (_scrollController.offset > 30) {
        setState(() {
          // _systemUiOverlayStyle = SystemUiOverlayStyle.light;
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
    _initAnimation(_bannerColors[0], _bannerColors[0]);
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
              top: ScreenApdar.setHeight(0),
              left: ScreenApdar.setWidth(0),
              right: ScreenApdar.setWidth(0),
            ),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: ScreenApdar.setHeight(_initBarHeight),
                    left: ScreenApdar.setWidth(10),
                    right: ScreenApdar.setWidth(10),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.value,
                        Theme.of(context).scaffoldBackgroundColor
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      // HeadTabBar(),
                      SwiperWidget(
                          indexChanged: (currentIndex) =>
                              _swiperChanged(currentIndex)),
                    ],
                  ),
                );
              },
              childCount: 1,
            ))),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              children: [
                HomeComponents(context).navGroupMenuWidget(),
                // moudles.map((e) => HomeComponents(context).companyGroup(e)),
                HomeComponents(context).companyGroup(moudles[0]),
                HomeComponents(context).companyGroup(moudles[1]),
                Container(
                 width: double.infinity,
                  height:ScreenApdar.setHeight(95.0),
                  margin: EdgeInsets.only(top:ScreenApdar.setHeight(10.0)),
                  child:HomeComponents(context).svgAsset('assets/images/banner_cap.svg'),
                )
                /* Column(
                  children: goulpkuData
                      .map((e) => HomeComponents(context).theirCoupons(e))
                      .toList(),
                ),*/
                /*  Column(
                  children: goulpkuData
                      .map((e) => HomeComponents(context).ipsumGroup(e))
                      .toList(),
                ),*/
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
              twoLevelWidget: TwoLevelWidget(setActivity: () {
                print('wwwwwwwwwwww');
              }),
            ),
        /*    headerBuilder:(BuildContext context)=>,*/

        child: Stack(
          children: [
            // HomeComponents(context).appBarbg(_swiperChangedIndex),
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

  dispose() {
    animationController.dispose();
    super.dispose();
  }
}
