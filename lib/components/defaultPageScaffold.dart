import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/floating_action_but.dart';
import 'package:flutter_demo/main_page/bottom_navigation_view.dart';
import 'package:flutter_demo/routers/navigator_admin.dart';
class DefaultPageScaffold extends StatefulWidget {
  final widgePage;
  const DefaultPageScaffold({Key key, this.widgePage}) : super(key: key);

  @override
  _DefaultPageScaffold createState() => _DefaultPageScaffold();
}

class _DefaultPageScaffold extends State<DefaultPageScaffold> {
  int _privatecurrentIndex = 0;

  _currentIndex(BuildContext context, int changedIndex) {
    setState(() {
      _privatecurrentIndex = changedIndex;
      NavigationAdmin(context).BottomNavigation(changedIndex);
      if (_privatecurrentIndex == 3) {
        _privatecurrentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    body: widget.widgePage,
    floatingActionButtonLocation:
    FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Builder(
      builder: (context) => FloatingActionBut(
          currentIndex: _privatecurrentIndex,
          setActivity: (currentIndex) =>
              _currentIndex(context, currentIndex)
      ),
    ),
    bottomNavigationBar: BottomNavigationView(
        currentIndex: _privatecurrentIndex,
        setActivity: (currentIndex) =>
            _currentIndex(context, currentIndex)),
    extendBody: true,
  );
}