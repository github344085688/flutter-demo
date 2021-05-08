import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TwoLevelWidget extends StatelessWidget {
  final setActivity;
  const TwoLevelWidget({Key key,this.setActivity}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/124.gif"),
            // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果,关联到TwoLevelHeader,如果背景一致的情况,请设置相同
            alignment: Alignment.topCenter,
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Wrap(
              children: <Widget>[
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    SmartRefresher.of(context).controller.twoLevelComplete();
                  },
                  child: Text("Back"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}