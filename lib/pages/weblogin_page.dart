import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/request.dart';
import 'package:flutter_app/utils/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

class WebloginPage extends StatefulWidget {
  WebloginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WebloginPageState createState() => _WebloginPageState();
}

class _WebloginPageState extends State<WebloginPage> {

  void getToken(code)async{
    Dio dio = new Dio();
    dio.options.headers[HttpHeaders.acceptHeader]="application/json";
    Map<String,dynamic> params = Map();
    params["client_id"]= client_id;
    params["client_secret"]= client_secret;
    params["code"]= code;
    String url = "https://github.com/login/oauth/access_token";
    Response res = await dio.get(url,queryParameters: params);
    print(res.toString());
    await Storage.set("token",res.toString());
    Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }
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
            initialUrl: "https://github.com/login/oauth/authorize?client_id="+client_id,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if(request.url.startsWith("http://qgithub.auth")){
                final url = request.url;
                final code = url.split("?code=")[1];
                print(code);
                getToken(code);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            } ,
          ),
        ),
      ),
    );
  }
}
