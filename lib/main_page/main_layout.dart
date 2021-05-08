import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/home_page.dart';
import 'package:shared/ui/placeholder/placeholder_card_tall.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/faxian_page/faxian.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key key}) : super(key: key);


  @override
  _MainLayout createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  ScrollController _scrollController = new ScrollController();
  double _initBarHeight = 75;
  double _setBarHeight = 41;
  double _toolbarHeight = 75;
  double _initSsearchRight =85;
  double _searchRight = 0;
  double _searchButtom = 4.0;
  double _opacity = 1.0;
  double _expandedHeight =78;
  Widget _child;

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
    //跳转到screen4，并且移除所有的页面直到screen1
//          Navigator.of(context).pushNamedAndRemoveUntil(
//              '/screen4', ModalRoute.withName('/screen1'));
  /*  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Screen4()),
        ModalRoute.withName('/screen1'));*/
    //打开Screen4页面，并销毁当前页
    // Navigator.of(context).pushReplacementNamed('/screen4');

    //也可以使用以下方式
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Screen3()));
    //当前在Screen4页面，点击回到Screen1，连带着Screen2，Screen3也一起退出
   // Navigator.of(context).popUntil(ModalRoute.withName('/screen1'));
    //点击退出当前页面，并将Screen3压入栈中
    //Navigator.of(context).popAndPushNamed('/screen3');


  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          _searchRight = _scrollController.offset * 2.5;
          _toolbarHeight = _initBarHeight - _scrollController.offset;
          _opacity  = (100  - _scrollController.offset* 2.5).round() / 100;
        });
      }
      else if (_scrollController.offset >30) {
        setState(() {
          _searchRight = _initSsearchRight;
          _opacity = 0.0;
          _toolbarHeight = _setBarHeight;
        });
      }
    });

  }

  int currentIndex = 0;
  Widget _getScrollWidget() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            // backgroundColor: Color(0x27174),
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: this._expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/material_design_3.png',
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              stretchModes: [StretchMode.fadeTitle],
            ),
            toolbarHeight: this._toolbarHeight,
            title: Container(
              height: this._toolbarHeight,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Positioned(
                    top: 4.0,
                    left: 0,
                    height: 40.0,
                    child: Opacity(
                      opacity: this._opacity,
                      child:Image.asset(
                        'assets/images/logo-index2.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),


                  ),
                  Positioned(
                    left: 0,
                    right: this._searchRight,
                    bottom: this._searchButtom,
                    child: Container(
                      height: 28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: "${this._opacity}",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: Icon(Icons.search,
                              size: 15.0, color: Colors.grey),
                          suffixIcon: Icon(Icons.camera_alt,
                              size: 15.0, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 40.0,
                    child: Container(
                      width: 35,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.crop_free,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 5.0,
                    child: Container(
                      width: 35,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ];
      },
      body: ListView(children: <Widget>[
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFF6B80AA),
            backgroundColor: Color(0xFF846969)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
        PlaceholderCardTall(
            height: 200,
            color: Color(0xFFD4D5D7),
            backgroundColor: Color(0xFFEAE9E9)),
      ]),
    );
  }

  _currentIndex(editText) {
    setState(() {
      currentIndex = editText;
      if(editText ==1){
        // Navigator.of(context).pushNamed(context,"classification");
        Navigator.pushNamed(context, '/classification');
      }else{
        _child = HomePage();
      }
      if (currentIndex == 3) {
        currentIndex = 0;
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePerson()),
                (route) => true);*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScrollWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => {},
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0x231ebab7),
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1), // 阴影的偏移量
                    color: Color(0xff2f363e), //投影颜色
                    blurRadius: 1.0, //阴影的模糊程度
                    spreadRadius: -1, // 扩散的程度，如果设置成正数，则会扩大阴影面积；负数的话，则会缩小阴影面积
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment(0, 3.0),
                  end: Alignment(0, -2.0),
                  colors: <Color>[
                    const Color(0xff20272f),
                    const Color(0xff7e93b1),
                  ],
                ),
              ),
              child: Image.asset(
                'assets/images/icom/sign.png',
                fit: BoxFit.cover,
              )),
          elevation: 3.0,
        ),
      ),
      bottomNavigationBar: BottomNavigationView(
          currentIndex: currentIndex,
          setActivity: (currentIndex) => _currentIndex(currentIndex)),
      extendBody: true,
    );
  }
}
