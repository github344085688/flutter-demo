import 'dart:async';

import 'package:flutter/cupertino.dart';

// 上下滚动的消息轮播
class Marquee extends StatefulWidget {
  int count; // 子视图数量
  IndexedWidgetBuilder itemBuilder; // 子视图构造器

  Marquee(this.count, this.itemBuilder);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  PageController _controller;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // 如果当前位于最后一页，则直接跳转到第一页，两者内容相同，跳转时视觉上无感知
      if (_controller.page.round() >= widget.count) {
        _controller.jumpToPage(0);
      }
      _controller.nextPage(
          duration: Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _controller,
      itemBuilder: (buildContext, index) {
        if (index < widget.count) {
          return widget.itemBuilder(buildContext, index);
        } else {
          return widget.itemBuilder(buildContext, 0);
        }
      },
      itemCount: widget.count + 1, // 在原数据末尾添加一笔数据(即第一笔数据)，用于实现无限循环滚动效果
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }
}
