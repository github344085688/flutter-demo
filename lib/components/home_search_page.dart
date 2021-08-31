import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MySearchDelegate <T extends ViewModelWidget>  extends SearchDelegate<String> {
  final List<String> _words = ['myHomePage', 'state', 'string'];
  final List<String> _history;

  MySearchDelegate(): _history = <String>[ '面试','Studio3','动画dfsfds','自定义View','性能优化','gradle','Camera','代码混淆 安全','逆向加固'],
        super();

  @override
  String get searchFieldLabel =>'点时关闭整个搜索页面';

  // 搜索栏左侧的图标和功能，点击时关闭整个搜索页面
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // 搜索到内容了
  @override
  Widget buildResults(BuildContext context) {
    //可以使用FutureBuilder  调用api发送网络请求
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('You have selected the word:', style: TextStyle(
                color: Theme.of(context).dividerColor,
                fontSize: 18.0) ,),
            GestureDetector(
              onTap: () {
                // Returns this.query as result to previous screen, c.f.
                // `showSearch()` above.
                this.close(context, this.query);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold,color:Theme.of(context).dividerColor,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 输入时的推荐及搜索结果
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions =
        _words.where((word) => word.startsWith(query));

    return this.query.isEmpty
        ? SearchContentView(
            historyDate: this._history,
            onSelected: (String suggestion) {
              this.query = suggestion;
              // this._history.insert(0, suggestion);
              showResults(context);
            })
        : _SuggestionList(
            query: this.query,
            suggestions: suggestions.toList(),
            onSelected: (String suggestion) {
              this.query = suggestion;
              // this._history.insert(0, suggestion);
              showResults(context);
            },
          );
  }

  // 搜索条右侧的按钮执行方法，我们在这里方法里放入一个clear图标。 当点击图片时，清空搜索的内容。
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                this.query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

class SearchContentView extends StatefulWidget {
  final List<String> historyDate;
  final ValueChanged<String> onSelected;
  const SearchContentView({this.historyDate,this.onSelected});

  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  List<Widget> _generateList() {
    return this.widget.historyDate.map<Widget>((item) => ButtonItem(item)).toList();
  }
  SearchItemView(List<String> showDate){
    return Container(
      child: Wrap(
        spacing: 10,
        // runSpacing: 0,
        children: _generateList(),
      ),
    );
  }

  ButtonItem(dynamic text){
    return RaisedButton(
      child: Text(text),
      color: Theme.of(context).buttonColor,
      onPressed: () {
        this. widget.onSelected(text);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Text(
              '历史搜索',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SearchItemView(this.widget.historyDate),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              '历史记录',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SearchItemView(this.widget.historyDate)
        ],
      ),
    );
  }
}
