import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';

class LoadingDialog extends Dialog {
  final bool canceledOnTouchOutside;
  LoadingDialog(this.canceledOnTouchOutside) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
        type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  if(canceledOnTouchOutside){
                    Navigator.pop(context);
                  }
                },
              ),
              Center(
                child: SizedBox(
                  width: ScreenApdar.setWidth(120.0),
                  height: ScreenApdar.setWidth(120.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenApdar.setWidth(20.0),
                          ),
                          child: Text(
                            '加载中...',
                            style: TextStyle(fontSize: 12.0,color: Colors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

}

/*

class LoadingDialog extends Dialog  {
  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child:

      Center(
        child: SizedBox(
          width: ScreenApdar.setWidth(120.0),
          height: ScreenApdar.setWidth(120.0),
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenApdar.setWidth(20.0),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 12.0,color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
