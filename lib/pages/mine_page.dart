import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/request.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MinePage> {
  String title = 'FutureBuilder使用';

  Future _gerData() async {
    var response = await DioUtil.get('/users/huxiaofan1223/repos', null);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
              builder: _buildFutureUser,
              future: _gerUserInfo(),
            ),
            // FutureBuilder(
            //   builder: _buildFuture,
            //   future: _gerData(),
            // ),
          ],
        ),
      )
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
        // return _createListView(context, snapshot);
        return Text("${snapshot.data.toString()}");
      default:
        return null;
    }
  }
  Widget _UserInfoView(BuildContext context, AsyncSnapshot snapshot) {
    final data = snapshot.data;
    final userInfo = jsonDecode(data);
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
    return response.toString();
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
