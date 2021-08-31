/*
 * @discripe: 业务层方法
 */
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_demo/components/loading.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:lottie/lottie.dart';
//
// import 'bloc.dart';
// import 'base.dart';
// import './dy_dialog/login.dart';
// import './dy_dialog/loading.dart';

abstract class Service {

  static String _formatNum(double number, int postion) {
    if((number.toString().length - number.toString().lastIndexOf(".") - 1) < postion) {
      // 小数点后有几位小数
      return ( number.toStringAsFixed(postion).substring(0, number.toString().lastIndexOf(".")+postion + 1).toString());
    } else {
      return ( number.toString().substring(0, number.toString().lastIndexOf(".") + postion + 1).toString());
    }
  }

  // 格式化时间
  static String formatTime(int timeSec) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeSec * 1000);
    var now = DateTime.now();
    var yesterday = DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch - 24 * 60 * 60 * 1000);

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return '今天${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return '昨天${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
  
  // 生成随机串
  static dynamic randomBit(int len, { String type }) {
    String character = type == 'num' ? '0123456789' : 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < len; i++) {
      left = left + character[Random().nextInt(character.length)]; 
    }
    return type == 'num' ? int.parse(left) : left;
  }
}

abstract class DYdialog {
    // 默认弹窗alert
  static void alert(context, {
    @required String text, String title = '提示', String yes = '确定',
    Function yesCallBack
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(yes),
              onPressed: () {
                if (yesCallBack != null) yesCallBack();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {});
  }

  // loadingDialog
  static void showLoading(context, {
    String title = '正在加载...'
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog(true);
      }
    );
  }

 /* static Future sendImage(String path) async {

  IMImageMsgModel m = IMImageMsgModel(localUrl: path);
  Image image = Image.file(File.fromUri(Uri.parse(path)));
  // 预先获取图片信息
  image.image.resolve(new ImageConfiguration()).addListener(
  new ImageStreamListener((ImageInfo info, bool _) {
  m.width = info.image.width;
  m.height = info.image.height;
  this.sendMsg(m);
  }));
}
 */

  // login
  /*static void showLogin(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoginDialog();
      }
    );
  }*/
}

// 禁用点击水波纹
class NoSplashFactory extends InteractiveInkFeatureFactory {
  @override
  InteractiveInkFeature create({
    MaterialInkController controller,
    RenderBox referenceBox,
    Offset position,
    Color color,
    TextDirection textDirection,
    bool containedInkWell = false,
    rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    onRemoved
  }) {
    return NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  }) : super(
    controller: controller,
    referenceBox: referenceBox,
  );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}

// 去除安卓滚动视图水波纹
class DyBehaviorNull extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context,child,axisDirection);
    }
  }
}

// 下拉刷新头部、底部组件
/*

class DYrefreshHeader extends StatelessWidget with DYBase {
  @override
  Widget build(BuildContext context) {
    final refreshing = Lottie.network(
      '${DYBase.baseUrl}/static/if_refresh.json',
      height: dp(50)
    );

    return CustomHeader(
      refreshStyle: RefreshStyle.Follow,
      builder: (BuildContext context,RefreshStatus status) {
        bool swimming = (status == RefreshStatus.refreshing || status == RefreshStatus.completed);
        return Container(
          height: dp(50),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              swimming ? SizedBox() : Image.asset(
                'images/fun_home_pull_down.png',
                height: dp(50),
              ),
              Offstage(
                offstage: !swimming,
                child: refreshing,
              ),
            ]
          )
        );
      }
    );
  }
}

class DYrefreshFooter extends StatelessWidget with DYBase {
  final bgColor;
  DYrefreshFooter({this.bgColor});

  @override
  Widget build(BuildContext context) {
    final height = dp(50);

    return CustomFooter(
      height: height,
      builder: (BuildContext context,LoadStatus mode){
        final textStyle = TextStyle(
          color: Color(0xffA7A7A7),
          fontSize: dp(13),
        );
        Widget body;
        Widget loading = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              '${DYBase.baseUrl}/static/loading.json',
              height: dp(34)
            ),
            Text(
              '用力加载中...',
              style: textStyle,
            ),
          ],
        );
        if(mode==LoadStatus.idle){
          body = loading;
        }
        else if(mode==LoadStatus.loading){
          body = loading;
        }
        else if(mode == LoadStatus.failed){
          body = Text(
            '网络出错啦 😭',
            style: textStyle,
          );
        }
        else if(mode == LoadStatus.canLoading){
          body = loading;
        }
        else{
          body = Text(
            '我是有底线的 😭',
            style: textStyle,
          );
        }
        return Container(
          color: bgColor,
          height: height,
          child: Center(child:body),
        );
      },
    );
  }
}*/

typedef AsyncImageWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, String url);

typedef AsyncImageFileWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, File file);

typedef AsyncImageMemoryWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, Uint8List bytes);

enum AsperctRaioImageType { NETWORK, FILE, ASSET, MEMORY }

///有宽高的Image
class AsperctRaioImage extends StatelessWidget {
  String url;
  File file;
  Uint8List bytes;
  final ImageProvider provider;
  AsperctRaioImageType type;
  AsyncImageWidgetBuilder<ui.Image> builder;
  AsyncImageFileWidgetBuilder<ui.Image> filebBuilder;
  AsyncImageMemoryWidgetBuilder<ui.Image> memoryBuilder;

  AsperctRaioImage.network(url, {Key key, @required this.builder})
      : provider = NetworkImage(url),
        type = AsperctRaioImageType.NETWORK,
        this.url = url;

  AsperctRaioImage.file(
      file, {
        Key key,
        @required this.filebBuilder,
      })  : provider = FileImage(file),
        type = AsperctRaioImageType.FILE,
        this.file = file;

  AsperctRaioImage.asset(name, {Key key, @required this.builder})
      : provider = AssetImage(name),
        type = AsperctRaioImageType.ASSET,
        this.url = name;

  AsperctRaioImage.memory(bytes, {Key key, @required this.memoryBuilder})
      : provider = MemoryImage(bytes),
        type = AsperctRaioImageType.MEMORY,
        this.bytes = bytes;

  @override
  Widget build(BuildContext context) {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = provider.resolve(config);
    ImageStreamListener listener;
    listener = ImageStreamListener(
          (ImageInfo image, bool sync) {
        completer.complete(image.image);
        stream.removeListener(listener);
      },
      onError: (dynamic exception, StackTrace stackTrace) {
        completer.complete();
        stream.removeListener(listener);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      },
    );
    stream.addListener(listener);

    return FutureBuilder(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          if (snapshot.hasData) {
            if (type == AsperctRaioImageType.FILE) {
              return filebBuilder(context, snapshot, file);
            } else if (type == AsperctRaioImageType.MEMORY) {
              return memoryBuilder(context, snapshot, bytes);
            } else {
              return builder(context, snapshot, url);
            }
          } else {
            return Container();
          }
        });
  }
}