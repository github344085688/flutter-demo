import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/imgProcessing.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/home_page/bottom_navigation/fluid_button.dart';
import 'package:flutter_demo/home_page/bottom_navigation/buttom_canvas.dart';
import 'package:flutter_demo/home_page/bottom_navigation/event_bus.dart';

class BottomNavigationView extends StatefulWidget {
  final setActivity;
  final int currentIndex;

  const BottomNavigationView({Key key, this.currentIndex, this.setActivity})
      : super(key: key);

  @override
  _BottomNavigationView createState() => _BottomNavigationView();
}

class _BottomNavigationView extends State<BottomNavigationView>
    with TickerProviderStateMixin {
  static const double nominalHeight = 56.0;
  int _selectedIndex = 0;
  Function handlePressed;

  List<Map> navCont = [
    {"icon": 'assets/images/icom/tag01.svg', "title": "首页"},
    {"icon": 'assets/images/icom/tag02.svg', "title": "发现"},
    {"icon": 'assets/images/icom/tag03.svg', "title": "消息"},
    {"icon": 'assets/images/icom/tag04.svg', "title": "我的"},
  ];

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
  }

  @override
  void initState() {
    _initAnimation(ComponentStyle.AVERAGE_COLOR, ComponentStyle.AVERAGE_COLOR);
    _selectedIndex = widget.currentIndex;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final appSize = MediaQuery.of(context).size;
    final height = nominalHeight;
    return Container(
      width: appSize.width,
      height: nominalHeight,
     /* decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: Offset(0.0, 0),
          blurRadius: 0.2,
        )
      ]),*/
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: ButtomCanvas(selectedIndex: _selectedIndex,bgColor:ComponentStyle.MALL_FOCUS_BG),
          ),
          Positioned(
            left: 0,
            top: 0.0,
            width: appSize.width,
            height: height,
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenApdar.setHeight(25.0),
              ),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                direction: Axis.horizontal,
                children: navCont
                    .asMap()
                    .entries
                    .map((e) => _navText(
                          e.key,
                          e.value,
                        ))
                    .toList(),
              ),
            ),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navCont
                  .asMap()
                  .entries
                  .map((e) => FluidNavBarButton(e.value,
                      _selectedIndex == e.key, () => _handlePressed(e.key)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  Widget _navText(int index, Map tag) {
    TextStyle textStyle =
        TextStyle(fontSize: 12.0, color: ComponentStyle.TITLE_TEXT_COLOR);
    if (_selectedIndex == index) {
      animationController.forward();
      textStyle = TextStyle(fontSize: 14.0, color: color.value);
    }

    Widget  _container = Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        // width: double.infinity,
        // height: double.infinity,
        child:  Text(
          tag['title'],
          style: textStyle,
        ),
      )
    );

    return _container;
  }

  void _handlePressed(int index) {
    eventBus.fire(new MyEvent(index));
    setState(() {
      _selectedIndex = index;
    });
    if (widget.setActivity != null) {
      widget.setActivity(index);
    }
  }
}
