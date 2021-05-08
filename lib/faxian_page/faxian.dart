import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/head_tab_bar.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/components/swiper_widget.dart';
import 'package:flutter_demo/components/app_bar-cliver.dart';
import 'package:shared/ui/placeholder/placeholder_card_tall.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Faxian extends StatefulWidget {
  const Faxian({Key key}) : super(key: key);

  @override
  _Faxian createState() => _Faxian();
}

class _Faxian extends State<Faxian> {
  ScrollController _scrollController = new ScrollController();
  double _initBarHeight = 75;
  double _setBarHeight = 41;
  double _toolbarHeight = 75;
  double _initSsearchRight = 85;
  double _searchRight = 0;
  double _searchButtom = 4.0;
  double _opacity = 1.0;
  double _expandedHeight = 78;
  List<Map> _listbanexData = [
    {"imagUrl": "assets/images/av1.png"},
    {"imagUrl": "assets/images/av2.png"},
    {"imagUrl": "assets/images/av3.png"},
    {"imagUrl": "assets/images/av4.png"},
  ];
  List<Map> _girdMenuWidgetData = [
    {'icon': Icons.delivery_dining},
    {'icon': Icons.all_out_sharp},
    {'icon': Icons.beach_access},
    {'icon': Icons.fire_hydrant},
    {'icon': Icons.free_breakfast},
    {'icon': Icons.fingerprint},
    {'icon': Icons.filter_drama_outlined},
    {'icon': Icons.blur_on_rounded},
    {'icon': Icons.bug_report_sharp},
    {'icon': Icons.deck_rounded},
  ];

  // final List fixedList = Iterable<int>.generate(_listbanexData.length).toList();

  SvgPicture _bannerTitle = new SvgPicture.asset(
    "assets/images/bannerTitle.svg",
    color: Colors.white,
    height: 80.0,
  );
  SvgPicture _bannerBg = new SvgPicture.asset(
    "assets/images/banner_bg.svg",
  );

  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
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
    });
  }

  int currentIndex = 0;

  Widget _girdWidget(Map data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Container(
          height: 30.0,
          width: 30.0,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            //背景装饰
            borderRadius: BorderRadius.all(Radius.circular(50)),
            gradient: RadialGradient(
                colors: [Color(0x23008D83), Color(0x2303c7c3)],
                center: Alignment.topLeft,
                radius: 20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(
              data['icon'],
              size: 20.0,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _girdMenuWidget() {
    return Container(
        height: 100,
        child: Wrap(
            spacing: 12.0, // 主轴(水平)方向间距
            runSpacing: -11.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //
            children: _girdMenuWidgetData.map((e) => _girdWidget(e)).toList()));
  }

  Widget _banexpanded(String images) {
    return Expanded(
        flex: 15,
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Image.asset(
            images,
            fit: BoxFit.contain,
          ),
        ));
  }

  Widget _bulletin() {
    return Container(
        height: 90.0,
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.only(left: 12.0, right: 5.0),
                decoration: BoxDecoration(
                  color: Color(0xffda4d65),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: _bannerTitle,
              ),
            ),
            Expanded(
              flex: 11,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Flex(
                    direction: Axis.horizontal,
                    children: _listbanexData
                        .map((e) => _banexpanded(e['imagUrl']))
                        .toList()),
              ),
            ),
          ],
        ));
  }

  Widget _svgbanner_bg(String svgUrl, Color color) {
    return SvgPicture.asset(
      svgUrl,
      color: color,
    );
  }

  List<Map> _goulpkuData  = [
    {
      'bgiconColor': Color(0xffFAA426),
      'topiconColor': Color(0xffD48731),
      'containerColor': Color(0xffF6D1A7),
      'title':'01',
      'lable':'Lorem Ipsum',
      'text':'Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elitv. '
          'Proin sed neque sed lorem hendrerit ',
    },
    {
      'bgiconColor': Color(0xffEF5C63),
      'topiconColor': Color(0xffBF4A4F),
      'containerColor': Color(0xffFFE0E2),
      'title':'02',
      'lable':'Lorem Ipsum',
      'text':'Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elitv. '
          'Proin sed neque sed lorem hendrerit ',
    },
    {
      'bgiconColor': Color(0xff2DA0D1),
      'topiconColor': Color(0xff1383AA),
      'containerColor': Color(0xffCCF2FF),
      'title':'03',
      'lable':'Lorem Ipsum',
      'text':'Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elitv. '
          'Proin sed neque sed lorem hendrerit ',
    },
    {
      'bgiconColor': Color(0xff435D74),
      'topiconColor': Color(0xff324657),
      'containerColor': Color(0xffE6F3FF),
      'title':'04',
      'lable':'Lorem Ipsum',
      'text':'Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elitv. '
          'Proin sed neque sed lorem hendrerit ',
    },
    {
      'topiconColor': Color(0xff448C79),
      'bgiconColor': Color(0xff60C7AB),
      'containerColor': Color(0xffD1FFF2),
      'title':'05',
      'lable':'Lorem Ipsum',
      'text':'Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elitv. '
          'Proin sed neque sed lorem hendrerit ',
    },
  ];
  Widget _goulpkus(Map gou){
    return Container(
      width: double.infinity,
      height: 90.0,
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Stack(
        children: [
          Positioned(
            top: 74.0,
            left: 94.0,
            child: _svgbanner_bg(
                "assets/images/banner_bg_bt.svg",gou['topiconColor']),
          ),
          Positioned(
            top: 4.0,
            bottom: 5.0,
            left: 0,
            right: 0,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color:gou['containerColor'],
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          Positioned(
            width: 100.0,
            height: 80.0,
            child: _svgbanner_bg(
                "assets/images/banner_bg.svg",  gou['bgiconColor']),
          ),
          Positioned(
              width: 65.0,
              height: 2.0,
              top: 68.0,
              left: 0,
              child:Container(
                decoration: BoxDecoration(
                  color:Colors.white,
                ),
              )
          ),
          Positioned(
            top: 28.0,
            left: 10,
            child:Text(gou['title'],style:TextStyle(
              color: Colors.white,
              fontSize: 40.0,
            ),),
          ),
          Positioned(
            top: 5.0,
            right: 10,
            child:Text(gou['lable'],style:TextStyle(
              color: gou['topiconColor'],
              fontSize: 16.0,
            ),),

          ),
          Positioned(
              top: 25.0,
              bottom: 0,
              left: 120.0,
              right: 10,
              child:Text(gou['text'], maxLines: 10,textAlign:TextAlign.right,  overflow: TextOverflow.ellipsis,style:TextStyle(
                color: gou['topiconColor'],
                fontSize: 12.0,
              ),)

          ),
        ],
      ),
    );
  }
  _swiperIndex(int index) {

  }

  Widget _getScrollWidget() {
    return
      NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBarCliver(
                initBarHeight: _initBarHeight,
                setBarHeight: _setBarHeight,
                toolbarHeight: _toolbarHeight,
                initSsearchRight: _initSsearchRight,
                searchRight: _searchRight,
                searchButtom: _searchButtom,
                opacity: _opacity,
                expandedHeight: _expandedHeight),
            SliverToBoxAdapter(
              child: Container(
                height: 335.0,
                child: Column(
                  children: <Widget>[
                    HeadTabBar(),
                    // SwiperWidget(),
                    // _girdMenuWidget(),
                    // _bulletin(),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          children:<Widget>[
            Column(
              // shrinkWrap: false,
              children:  _goulpkuData
                  .map((e) => _goulpkus(e))
                  .toList(),
            ),
            PlaceholderCardTall(
                height: 200,
                color: Color(0xFF6B80AA),
                backgroundColor: Color(0xFF846969)),
            PlaceholderCardTall(
                height: 200,
                color: Color(0xFF6B80AA),
                backgroundColor: Color(0xFF846969)),
          ],
        ));
  }

  _currentIndex(editText) {
    setState(() {
      currentIndex = editText;
      if (editText == 0) {
        Navigator.pushNamed(context, '/');
      }
      if (editText == 1) {
        Navigator.pushNamed(context, '/classification');
      }
      if (editText == 2) {
        Navigator.pushNamed(context, '/myMine');
      }
      if (editText == 3) {
        Navigator.pushNamed(context, '/new');
      }

      if (currentIndex == 3) {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return Scaffold(
      body: _getScrollWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionBut(),
      ),
      bottomNavigationBar: BottomNavigationView(
          currentIndex: currentIndex,
          setActivity: (currentIndex) => _currentIndex(currentIndex)),
      extendBody: true,
    );
  }
}
