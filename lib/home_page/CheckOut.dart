import 'package:flutter/material.dart';
// import 'package:flutter_jdshop/services/ScreenAdapter.dart';

import 'package:flutter_demo/components/screenApdar.dart';
class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Widget _checkOutItem() {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenApdar.setWidth(160),
          child: Image.network(
              "https://www.itying.com/images/flutter/list2.jpg",
              fit: BoxFit.cover),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("华为旗舰店Mate9手机", maxLines: 2),
                Text("白色,175", maxLines: 1),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("￥1111", style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('2'),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('结算'),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.add_location),
                        title: Center(child: Text("请添加收货地址")),
                        trailing: Icon(Icons.navigate_next),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.add_location),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('张三 13325187796'),
                            SizedBox(height: 10),
                            Text('北京海淀区')
                          ],
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenApdar.setWidth(20)),
                  child: Column(
                    children: <Widget>[
                      _checkOutItem(),
                      Divider(),
                      _checkOutItem(),
                      Divider(),
                      _checkOutItem()
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenApdar.setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('商品总金额￥100'),
                      Divider(),
                      Text('立减：￥5'),
                      Divider(),
                      Text('运费：￥8')
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              width: ScreenApdar.setWidth(750),
              height: ScreenApdar.setHeight(100),
              child: Container(
                width: ScreenApdar.setWidth(750),
                height: ScreenApdar.setHeight(100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Text("总价：140", style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child:
                        Text("立即下单", style: TextStyle(color: Colors.white)),
                        color: Colors.red,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}