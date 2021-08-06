import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/navigator_admin.dart';
class NavConteroller{
  static currentIndex(BuildContext context, int changedIndex) {
     NavigationAdmin(context).BottomNavigation(changedIndex);
  /*  setState(() {
      _privatecurrentIndex = changedIndex;
      if (_privatecurrentIndex == 3) {
        _privatecurrentIndex = 0;
      }
    });*/
  }
}