import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionBut extends StatefulWidget {
  const FloatingActionBut({Key key}) : super(key: key);

  @override
  _FloatingActionBut createState() => _FloatingActionBut();
}

class _FloatingActionBut extends State<FloatingActionBut> {
  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => {},
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0x231ebab7), width: 2, style: BorderStyle.solid),
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
      );
}
