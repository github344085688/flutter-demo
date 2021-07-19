import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/components/imgProcessing.dart';
import 'package:flutter_demo/components/screenApdar.dart';
class BottomNavigationView extends StatefulWidget{
  final setActivity;
  final int currentIndex;
  const BottomNavigationView({Key key,this.currentIndex,this.setActivity }):super(key: key);
  @override
  _BottomNavigationView createState()=>_BottomNavigationView();


}

class _BottomNavigationView extends State<BottomNavigationView> with TickerProviderStateMixin{
    AnimationController animationController;
    Animation<Color> color;
  _initAnimation(
      Color _beginColor,
      Color _endColor,
      ) {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    color = ColorTween(
      begin: _beginColor,
      end: _endColor,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }


  @override
  void initState() {
    _initAnimation(ComponentStyle.DIVIDER_COLOR, ComponentStyle.AVERAGE_COLOR);
    super.initState();
  }
  // color.value,
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child:Container(
          child: BottomAppBar(
            elevation:10.0,
            shape: CircularNotchedRectangle(),
            clipBehavior:Clip.antiAlias,
            notchMargin: 6.0,
            color: ComponentStyle.INDICATOR_COLOR,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,//均分底部导航栏横向空间
              children: <Widget>[
                _buildBotomItem(widget.currentIndex,widget.setActivity, 0, 'assets/images/icom/tag01.svg', "首页"),
                _buildBotomItem(widget.currentIndex,widget.setActivity, 1, 'assets/images/icom/tag02.svg', "发现"),
                _buildBotomItem(widget.currentIndex,widget.setActivity, -1, null, ""),
                _buildBotomItem(widget.currentIndex,widget.setActivity, 2, 'assets/images/icom/tag03.svg', "消息"),
                _buildBotomItem(widget.currentIndex,widget.setActivity, 3, 'assets/images/icom/tag04.svg', "我的"),
              ],
            ),
          ),
        ),
      ),
    );
  }


    Widget _buildBotomItem(int currentIndex,dynamic setActivity, int index, String iconData, String title) {

      TextStyle textStyle = TextStyle(fontSize: 12.0,color: ComponentStyle.DIVIDER_COLOR);
      EdgeInsetsGeometry padding = EdgeInsets.only(top: 4.0);
      dynamic iconSvg = iconData!=null ? ImgProcessing.svgbannerBg(iconData, ComponentStyle.DIVIDER_COLOR):null;
      if(currentIndex==index){    //选中状态的文字样式
        animationController.forward();
         textStyle = TextStyle(fontSize: 12.0,color: color.value);
         iconSvg = ImgProcessing.svgbannerBg(iconData, color.value);
      }
      Widget padItem = SizedBox();
      if (iconData != null) {
        padItem = Padding(
          padding: padding,
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenApdar.setWidth(18.0),
                    height: ScreenApdar.setHeight(18.0),
                    child: iconSvg,
                  ),
                  Text(
                    title,
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
        );
      }
      Widget item = Expanded(
        flex: 1,
        child: new GestureDetector(
          onTap: () {
            if (index != currentIndex) {
              setActivity(index);// 调用父级组件方法
            }
          },
          child: SizedBox(
            height: 52,
            child: padItem,
          ),
        ),
      );
      return item;
    }

    dispose() {
      animationController.dispose();
      super.dispose();
    }
}
