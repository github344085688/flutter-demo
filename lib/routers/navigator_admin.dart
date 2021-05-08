import 'package:flutter/material.dart';

class NavigationAdmin {
  BuildContext _context;
  NavigationAdmin(BuildContext context) {
    _context = context;
  }

  void BottomNavigation(int changedIndex) {
    if (changedIndex == 0) {
      Navigator.pushNamed(_context, '/');
    }
    if (changedIndex == 1) {
      Navigator.pushNamed(_context, '/classification');
    }
    if (changedIndex == 2) {
      Navigator.pushNamed(_context, '/myMine');
    }
    if (changedIndex == 3) {
      Navigator.pushNamed(_context, '/new');
    }
  }
// @override
// _BottomNavigation createState() => _BottomNavigation();
}
//
// class _BottomNavigation extends State<BottomNavigation> {
//   @override
//   Widget build(BuildContext context) => {
//
//   }
// }