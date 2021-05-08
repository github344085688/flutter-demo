import 'dart:math'; //这个让pow不报错
import 'package:flutter/material.dart';

// @override
class AnimationPage extends StatefulWidget {
  final startPosition;
  final endPosition;

  const AnimationPage({Key key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  _AnimationPage createState() => _AnimationPage();
}

// with SingleTickerProviderStateMixin 这个要加上
class _AnimationPage extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  double top = 0; // 要移动的红点距离顶部的距离
  double left = 0; // 要移动的红点距离左边的距离

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // 二阶贝塞尔曲线用值
    //开始
    var x0 = widget.startPosition.dx;
    var y0 = widget.startPosition.dy;

    var x1 = widget.startPosition.dx - 0;
    var y1 = widget.startPosition.dy - 100;

    // 结束
    var x2 = widget.endPosition.dx;
    var y2 = widget.endPosition.dy;

    _animation.addListener(() {
      // t 动态变化的值
      var t = _animation.value;
      if (mounted)
        setState(() {
          left = pow(1 - t, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0 + 2 * t * (1 - t) * y1 + pow(t, 2) * y2;
        });
    });

    // 初始化小圆点的位置
    left = widget.startPosition.dx;
    top = widget.startPosition.dy;

    // 显示小圆点的时候动画就开始
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: top,
          left: left,
          child: ClipOval(
            child: Icon(
              Icons.shopping_basket,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  // 销毁
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
