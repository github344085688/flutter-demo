import 'package:flutter/material.dart';
class BottomNavigationView extends StatelessWidget {
  final setActivity;
  final int currentIndex;
  const BottomNavigationView({Key key,this.currentIndex,this.setActivity }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //背景装饰
        /*    gradient: RadialGradient(
            //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft),*/
      ),
      // margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      child: ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(30)),
        child:Container(
          /* decoration: BoxDecoration(
             //背景装饰
             gradient: RadialGradient(
               //背景径向渐变
                 colors: [Colors.red, Colors.orange],
                 center: Alignment.topLeft),
           ),*/
          child: BottomAppBar(
            //悬浮按钮 与其他菜单栏的结合方式
            elevation:10.0,
            shape: CircularNotchedRectangle(),
            clipBehavior:Clip.antiAlias,
            //设置底栏的形状，一般使用这个都是为了和floatingActionButton融合，
            // 所以使用的值都是CircularNotchedRectangle(),有缺口的圆形矩形。
            // FloatingActionButton和BottomAppBar 之间的差距
            notchMargin: 6.0,
            color: Color(0xff495564),
            //  color: Color.alphaBlend(Colors.lightGreen,Colors.red),
            //  color: Color.lerp(Colors.lightGreen,Colors.red, 150.0),

            // .fromRGBO(77, 99, 104, 1)
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,//均分底部导航栏横向空间
              children: <Widget>[
                _buildBotomItem(currentIndex,setActivity, 0, 'assets/images/icom/tb_set_de.png', "首页"),
                _buildBotomItem(currentIndex,setActivity, 1, 'assets/images/icom/tb_red_pr.png', "发现"),
                _buildBotomItem(currentIndex,setActivity, -1, null, ""),
                _buildBotomItem(currentIndex,setActivity, 2, 'assets/images/icom/tb_cet_pr.png', "消息"),
                _buildBotomItem(currentIndex,setActivity, 3, 'assets/images/icom/tb_sig_pr.png', "我的"),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

_buildBotomItem(int currentIndex,dynamic setActivity, int index, String iconData, String title) {
  //未选中状态的样式
  TextStyle textStyle = TextStyle(fontSize: 10.0,color: Colors.grey[50]);
  EdgeInsetsGeometry padding = EdgeInsets.only(top: 4.0);

  if(currentIndex==index){    //选中状态的文字样式
    textStyle = TextStyle(fontSize: 13.0,color: Colors.blue);
    iconData= 'assets/images/icom/tb_set_pr.png';
  }
  Widget padItem = SizedBox();
  if (iconData != null) {
    padItem = Padding(
      padding: padding,
      child: Container(

        // color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                iconData,
                width: 25.0,
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
