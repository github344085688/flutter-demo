import 'package:flutter/material.dart';
import 'package:flutter_demo/components/screenApdar.dart';
import 'package:flutter_demo/style/style.dart';
import 'package:flutter_demo/servers/shared_sersvers.dart';
import 'package:flutter_demo/share_share/search_step_vm.dart';
import 'package:stacked/stacked.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  var _keywords;
  var _clipRectHeight = 50.0;
  List<String> searchKeys = [];
  List<String> _historySearchKeys = [];
  List<String> _foundSearch = [
    '驱邪扶正',
    '文化',
    '重现经典',
    '递向善力量',
    '体力劳动者代名词',
    '打造清朗',
    '饭圈',
  ];
  TextEditingController _controller = TextEditingController();

  void setClipRectHeight() {
    setState(() {
      _clipRectHeight = 200.0;
    });
  }

  setSearchKeys() async {
    _controller.clear();
    List<String> historySearchKeys;
    historySearchKeys =
        await SharedSersvers.getPreference("searchKeys", List) ?? [];
    if (!historySearchKeys.contains(_keywords) && _keywords != null) {
      if (historySearchKeys.length > 8) {
        historySearchKeys.removeLast();
      }
      historySearchKeys.insert(0, _keywords);
      await SharedSersvers.setPreference('searchKeys', List, historySearchKeys);
      historySearchKeys =
          await SharedSersvers.getPreference("searchKeys", List) ?? [];
    }
    setState(() {
      historySearchKeys != null
          ? _historySearchKeys = historySearchKeys
          : _historySearchKeys = [];
      _keywords = null;
    });
  }

  removeSearchKeys() async {
    await SharedSersvers.remove("searchKeys");
    setState(() {
      _historySearchKeys = [];
    });
  }

  void getSearchKeys() {}

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _controllerTextField() {
    _controller.text = '';
  }

  @override
  void initState() {
    setSearchKeys();
    _controllerTextField();
    setState(() {});
    super.initState();
  }

  Widget _BuildhistoryKeys() {
    return SliverPadding(
        padding: EdgeInsets.only(
          top: ScreenApdar.setHeight(0),
          left: ScreenApdar.setWidth(10.0),
          right: ScreenApdar.setWidth(10.0),
        ),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ClipRect(
            child: Container(
              height: _clipRectHeight,
              width: double.infinity,
              child: Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                runSpacing: 4.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.start, //沿
                children: _historySearchKeys.map((history) {
                  return Chip(
                    label: new Text('$history'),
                  );
                }).toList(),
              ),
            ),
          ),
          childCount: 1,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.navigate_before_sharp,
                    size: ScreenApdar.setFontSize(27.0),
                    color: Theme.of(context).dividerColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: Container(
                height: ScreenApdar.setHeight(27.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ComponentStyle.AVERAGE_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(30.0)),
                child: TextField(
                  autofocus: true,
                  controller: _controller,
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none)),
                  onChanged: (value) {
                    this._keywords = value;
                  },
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(ScreenApdar.setWidth(5)),
                  child: FlatButton(
                    color: ComponentStyle.MALL_FOCUS_BG,
                    height: ScreenApdar.setHeight(27.0),
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding:
                        EdgeInsets.only(bottom: ScreenApdar.setHeight(2.0)),
                    child: Text(
                      '搜索',
                      style: TextStyle(fontSize: ScreenApdar.setFontSize(14.0)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    onPressed: () {
                      if (this._keywords != null) this.setSearchKeys();
                    },
                  ),
                )),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
              padding: EdgeInsets.only(
                left: ScreenApdar.setWidth(10.0),
                right: ScreenApdar.setWidth(10.0),
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('历史搜索',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                      Center(
                        child: new Opacity(
                          opacity: _clipRectHeight == 50 ? 1 : 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: ComponentStyle.MALL_FOCUS_BG,
                            ),
                            onPressed: () => setClipRectHeight(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: ComponentStyle.MALL_FOCUS_BG,
                        ),
                        onPressed: () => removeSearchKeys(),
                      ),
                    ],
                  );
                },
                childCount: 1,
              ))),
          _BuildhistoryKeys(),
          SliverPadding(
              padding: EdgeInsets.only(
                left: ScreenApdar.setWidth(10.0),
                right: ScreenApdar.setWidth(10.0),
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('搜索发现',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      )
                    ],
                  );
                },
                childCount: 1,
              ))),
          SliverPadding(
              padding: EdgeInsets.only(
                top: ScreenApdar.setHeight(0),
                left: ScreenApdar.setWidth(10.0),
                right: ScreenApdar.setWidth(10.0),
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => ClipRect(
                  child: Wrap(
                    spacing: 8.0, // 主轴(水平)方向间距
                    runSpacing: 4.0, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.start, //沿
                    children: _foundSearch.map((history) {
                      return Chip(
                        label: new Text('$history'),
                      );
                    }).toList(),
                  ),
                ),
                childCount: 1,
              )))
        ],
      ),
    );
  }
}
