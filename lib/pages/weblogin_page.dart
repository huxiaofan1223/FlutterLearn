import 'package:flutter/material.dart';
import 'package:flutter_app/utils/request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebloginPage extends StatefulWidget {
  WebloginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WebloginPageState createState() => _WebloginPageState();
}

class _WebloginPageState extends State<WebloginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub认证'),
        automaticallyImplyLeading : true,
      ),
      body: Center(
        child:SafeArea(
          child: WebView(
              initialUrl: "https://github.com/login/oauth/authorize?client_id="+client_id
          ),
        ),
      ),
    );
  }
}
