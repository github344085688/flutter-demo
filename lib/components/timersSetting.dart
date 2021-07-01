import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/screenApdar.dart';

class TimersSetting extends StatefulWidget {
  const TimersSetting({Key key}) : super(key: key);

  @override
  _TimersSetting createState() => _TimersSetting();
}

class _TimersSetting extends State<TimersSetting>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  String get hoursString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${(duration.inHours)..toString().padLeft(2, '0')}';
  }

  String get minutesString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  }

  String get secondsString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void initState() {
    //倒计时,注意vsync:this，这里需要混入TickerProviderStateMixin
    _animationController = AnimationController(
        vsync: this, duration: Duration(hours: 10, minutes: 30, seconds: 0));
    _animationController.reverse(
        from: _animationController.value == 0.0
            ? 1.0
            : _animationController.value);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animationController,
      builder: (_, Widget child) {
        return Column(
          children:[hoursString,minutesString,secondsString].asMap().entries.map((timeString)=>  Container(
            alignment:Alignment.center,
            height: ScreenApdar.setHeight(10),
            width: double.infinity,
            margin:EdgeInsets.only(top:4.0),
            decoration: BoxDecoration(
              color:  ComponentStyle.LINE_COLOR,
                // gradient: LinearGradient(colors: [
                //   ComponentStyle.MAIN_COLOR,
                //   ComponentStyle.LINE_COLOR
                // ]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: ComponentStyle.INDICATOR_COLOR,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.6,
                    spreadRadius: -0.5,
                  )
                ]),
            child: Text(
              '${timeString.value}${timeString.key!=2?':':' '}',
              style: TextStyle(
                  color: ComponentStyle.ACCENT_COLOR, fontSize: 10.0),
            ),
          )).toList(),

        );
      });
}
