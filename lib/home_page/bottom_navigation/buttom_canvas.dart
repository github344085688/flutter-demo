import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home_page/bottom_navigation/linear_point_curve.dart';
import 'package:flutter_demo/home_page/bottom_navigation/event_bus.dart';
import 'package:flutter_demo/style/style.dart';
class ButtomCanvas extends StatefulWidget {
  final int selectedIndex;
  Color bgColor;

  ButtomCanvas({Key key, this.selectedIndex,this.bgColor}) : super(key: key);

  @override
  _ButtomCanvas createState() => _ButtomCanvas();
}

class _ButtomCanvas extends State<ButtomCanvas> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController animationController;
  AnimationController _xController;
  AnimationController _yController;

  double  _selectedx = 0;

  @override
  void initState() {
    eventBus.on<MyEvent>().listen((MyEvent data) => _handlePressed(data.index));

    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_yController]).addListener(() {
      setState(() {});
    });
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _selectedx =  _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 50.0;

    super.didChangeDependencies();
  }


  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  double _indexToPosition(int index) {
    const buttonCount = 4.0; //导航数量
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }


  void _handlePressed(int index) {

    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });
    // print('ssssss${index}');
    _yController.value = 1.0;
    _selectedx = _indexToPosition(index) / MediaQuery.of(context).size.width;
    // _yController.animateTo(20, duration: Duration(milliseconds: 500));
    _yController.animateTo(0.0, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final inCurve = ElasticOutCurve(5.38);
    return CustomPaint(
      painter: _BackgroundCurvePainter(
          _selectedx * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInOut.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          widget.bgColor),
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }
}

class _BackgroundCurvePainter extends CustomPainter {
  static const _radiusTop = 30.0;
  static const _radiusBottom = 9.2;
  static const _horizontalControlTop = 0;
  static const _horizontalControlBottom = 0;
  static const _pointControlTop = 0;
  static const _pointControlBottom = 1;
  static const _topY = -14.0;
  static const _bottomY = 0.0;
  static const _topDistance = 0.0;
  static const _bottomDistance = 0.0;

  final double _x;
  final double _normalizedY;
  final Color _color;


  _BackgroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;

  @override
  void paint(canvas, size) {

    final offsetCurve =  Curves.elasticOut ;
    final lineBoxShadow = Paint()
      ..color = ComponentStyle.INDICATOR_COLOR
      // ..maskFilter = MaskFilter.blur(BlurStyle.inner, 2.0)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0.0, -0.5), Offset(size.width, -0.5), lineBoxShadow);
    final norm = LinearPointCurve(0.5, 50.0).transform(_normalizedY) / 100;

    // print('----------=${_normalizedY}');
    final y = Tween<double>( begin:_topY, end: _bottomY)
        .transform(LinearPointCurve(0.1, 0.7).transform(norm));
    final x0 = _x;
    canvas.drawOval(Rect.fromLTRB(x0-20,  y, x0+20, y+40),
        Paint()..color = ComponentStyle.MALL_FOCUS_BG
          ..style = PaintingStyle.fill);
    canvas.drawOval(Rect.fromLTRB(x0-20.5,  y-0.5, x0+20.5, y+40),
        Paint()
          ..color = ComponentStyle.INDICATOR_COLOR
        // ..maskFilter = MaskFilter.blur(BlurStyle.inner, 2.0)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);

    final _paint = Paint()..color = ComponentStyle.MALL_FOCUS_BG;
    final bgpath = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(bgpath, _paint);
  }

  @override
  bool shouldRepaint(_BackgroundCurvePainter oldPainter) {
    return _x != oldPainter._x ||
        _normalizedY != oldPainter._normalizedY ||
        _color != oldPainter._color;
  }
}
