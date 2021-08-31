import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

// import 'goods_info_page.dart';

///商品详情页面，实现淘宝京东等效果
class ShopDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopDetailState();
  }
}

class ShopDetailState extends State with SingleTickerProviderStateMixin {
  int _value = 0;
  static final List<GlobalKey> _key = List.generate(100, (index) => GlobalKey());
  final List<Widget> buttons = List.generate( 100,  (index) => RaisedButton(
      onPressed: () {},
      color: index % 2 == 0 ? Colors.grey : Colors.white,
      child: Text("Button No # ${index + 1}", key: _key[index]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RaisedButton( onPressed: () {
          setState(() {
            print("calling");
            Scrollable.ensureVisible(_key[50].currentContext);
          });
        },
          child: Text("Button No # "),),
      ),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buttons,
                  );
                },
                childCount: 1,
              ),
            )
          ]
      ),

     /* Column(
        children: [
          DropdownButton(
            value: _value,
            items: List.generate(
              20,
                  (index) => DropdownMenuItem(
                  child: Text("Goto Button # ${index + 1}"), value: index),
            ),
            onChanged: (value) {
              setState(() {
                _value = value;
                print("calling");
                Scrollable.ensureVisible(_key[value].currentContext);
              });
            },
          ),
          SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buttons,
            ),
          ),

        ],
      ),*/
    );
  }
  ///创建底部栏
  BottomAppBar buildBottomBar(){
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            Expanded(
                flex: 3,
                child: Text("联系客服")),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffff9b00", radix: 16)),
                    Color(int.parse("ffF8CD6A", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(child: Text("加入购物车", style: TextStyle(color: Colors.white),)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse("ffFF5252", radix: 16)),
                    Color(int.parse("ffFF0000", radix: 16)),
                  ]),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Center(child: Text("直接购买", style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}