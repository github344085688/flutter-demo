import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/style/style.dart';

class FloatingActionBut extends StatefulWidget {
  final setActivity;
  final currentIndex;
  const FloatingActionBut({Key key, this.currentIndex, this.setActivity }) : super(key: key);

  @override
  _FloatingActionBut createState() => _FloatingActionBut();
}

class _FloatingActionBut extends State<FloatingActionBut> {
  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => {
          if(widget.currentIndex != 4) widget.setActivity?.call(4),
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: ComponentStyle.INDICATOR_COLOR, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  color:  ComponentStyle.DIVIDER_COLOR,
                  blurRadius: 1.0,
                  spreadRadius: -1,
                )
              ],
              gradient: LinearGradient(
                begin: Alignment(0, 3.0),
                end: Alignment(0, -2.0),
                colors: <Color>[
                  ComponentStyle.MALL_FOCUS_BG,
                  ComponentStyle.MALL_FOCUS_BG,
                ],
              ),
            ),
            child: Image.asset(
              'assets/images/icom/sign.png',
              fit: BoxFit.cover,
            )),
        elevation: 3.0,
      );
}
