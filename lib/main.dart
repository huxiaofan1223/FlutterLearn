import 'package:flutter/material.dart';
import 'package:flutter_app/TabPage.dart';
import 'package:flutter_app/pages/second_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/weblogin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"test app",
      initialRoute: '/',
      routes: {
        '/': (context) => WebloginPage(),
        '/Home': (context) => TabPage(),
        '/Second': (context) => SecondPage()
      },
    );
  }
}