import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/request.dart';
import 'package:flutter_app/utils/utils.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MinePage> {
  String title = 'FutureBuilder使用';

  Future _getRepos() async {
    var response = await DioUtil.get('/user/repos', null);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top:30),
        child: Column(
          children: [
            FutureBuilder(
              builder: _buildFutureUser,
              future: _gerUserInfo(),
            ),
            FutureBuilder(
              builder: _buildFuture,
              future: _getRepos(),
            ),
          ],
        ),
      )
    );
  }
  Widget _renderLang(lang){
    const dict = {
      "Java":"#b07219",
      "Python":"#3572A5",
      "JavaScript":"#f1e05a",
      "Vue":"#2c3e50",
      "TypeScript":"#2b7489",
      "Swift":"#ffac45",
      "Go":"#00ADD8",
      "PHP":"#4F5D95",
      "HTML":"#e34c26",
      "Dockerfile":"#384d54",
      "C":"#555555",
      "CSS":"#563d7c",
      "Shell":"#89e051",
      "Hack":"#878787",
      "Objective-C":"#438eff",
      "Lua":"#000080",
      "C#":"#178600",
      "C++":"#f34b7d",
      "Pascal":"#E3F171",
      "Perl":"#0298c3",
      "Kotlin":"#F18E33",
      "Jupyter Notebook":"#DA5B0B",
      "Dart":"#00B4AB"
    };
    return Container(
      child: Row(
        children: [
          Container(
            height:10,
            width:10,
            margin:EdgeInsets.only(right:5),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular((5)),
              color:HtmlColor(dict[lang]),
            ) ,
          ),
          new Text(
            lang,
            style: new TextStyle(
              color:HtmlColor("#555555")
          ),),
        ],
      ),
    );
  }
  Widget _repoItem(repo) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: new BoxDecoration(
            border: new Border.all(color: HtmlColor("#ebebeb"), width: 0.5),
            borderRadius: new BorderRadius.circular((5))),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                new Text(
                  repo["name"],
                  style: new TextStyle(
                      fontSize: 17,
                      color:HtmlColor("#1e90ff")
                  ),
                ),
                SizedBox(width:20),
                repo["private"]?
                new Container(
                  padding: EdgeInsets.only(left:5,right:5),
                  height:16,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: new BorderRadius.circular((8)),
                  ),
                  child:Center(
                    child: new Text(
                      "Private",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                ):new Container(),
              ],
            ),
            SizedBox(height:5),
            new Text(
              repo["description"],
              style: new TextStyle(
                  color:HtmlColor("#555555")
              ),
            ),
            SizedBox(height:5),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                _renderLang('${repo["language"]}'),
                new Text(
                    '${repo["stargazers_count"]}',
                    style: new TextStyle(
                      color:HtmlColor("#555555")
                    ),
                ),
                new Text(
                  '${repo["updated_at"]}',
                  style: new TextStyle(
                      color:HtmlColor("#555555")
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: ()=>{print(repo["name"])},
    );
  }

  Widget _ReposListView(BuildContext context, AsyncSnapshot snapshot) {
    List repos = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) => _repoItem(repos[index]),
      itemCount: repos.length,
      shrinkWrap: true,
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        // return _ReposListView(context, snapshot);
        return Expanded(child:_ReposListView(context, snapshot));
      default:
        return null;
    }
  }
  Widget _UserInfoView(BuildContext context, AsyncSnapshot snapshot) {
    final userInfo = snapshot.data;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              new ClipOval(
                child: Image.network(
                  userInfo["avatar_url"],
                  width:60,
                  height:60,
                ),
              ),
              SizedBox(
                width:20
              ),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  new Text(
                    userInfo["name"],
                    style: new TextStyle(
                      fontSize: 22
                    ),
                  ),
                  new Text(userInfo["login"]),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  Future _gerUserInfo() async {
    var response = await DioUtil.get('/user', null);
    return response;
  }
  Widget _buildFutureUser(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        // return _createListView(context, snapshot);
        return _UserInfoView(context,snapshot);
      default:
        return null;
    }
  }
}
