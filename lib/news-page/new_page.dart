import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
class NewPage extends StatefulWidget {
  const NewPage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<NewPage> with TickerProviderStateMixin{

  AnimationController _animationController;

  String get hoursString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inHours)..toString().padLeft(2, '0')}';
  }

  String get minutesString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  }

  String get secondsString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

 /* void initState() {
    //倒计时,注意vsync:this，这里需要混入TickerProviderStateMixin
    _animationController = AnimationController(vsync: this, duration: Duration(hours: 10, minutes: 30, seconds: 0));
    _animationController.reverse(from: _animationController.value == 0.0 ? 1.0 : _animationController.value);
  }*/


  Widget build(BuildContext context) {
    return
      AnimatedBuilder(
          animation: _animationController,
          builder: (_, Widget child) {
            return Row(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
               child: Column(
                 children: [
                   Text(
                     secondsString,
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ), Text(
                     hoursString,
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ), Text(
                     minutesString,
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ),
                 ],
               )
               /* child: Container(
                  color: Colors.red,
                  child: Text(
                    secondsString,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),*/
              ),
            ]);
          });

  }


  dispose() {
    // animationController.dispose();
    super.dispose();
  }
}

