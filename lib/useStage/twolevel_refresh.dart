import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TwoLevelExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TwoLevelExampleState();
  }
}

class _TwoLevelExampleState extends State<TwoLevelExample> {
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];


  Widget buildCtn() {
    return
      ListView.separated(
        // reverse: true,
        padding: EdgeInsets.only(left: 5, right: 5),
        itemBuilder: (c, i) => Text( data[i]),
        separatorBuilder: (context, index) {
          return Container(
          );
        },
        itemCount: data.length,
      );
  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      child:MaterialApp(
        title: 'Flutter Demo',
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            body:Builder(builder: (BuildContext context) {
              return RefreshConfiguration.copyAncestor(
                enableLoadingWhenFailed: true,
                context: context,
                child: Scaffold(
                    body:  SmartRefresher(
                      controller: _refreshController,

                      child: buildCtn(),
                      enablePullUp: true,
                      physics: BouncingScrollPhysics(),
                     /* footer: ClassicFooter(
                        loadStyle: LoadStyle.ShowWhenLoading,
                        completeDuration: Duration(milliseconds: 500),
                      ),*/

                    )
                ),
                footerBuilder: () => WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                // footerTriggerDistance: 30.0,
              );
            }),);
        }),
      )
    );

  }

}

