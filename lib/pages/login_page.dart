import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/utils/request.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _LoginPageState extends State<LoginPage> {
  var username = "";
  var password = "";

  void _usernameChanged(String str) {
    setState(() {
      username=str;
    });
  }
  void _passwordChanged(String str) {
    setState(() {
      password=str;
    });
  }
  void login() async{
    if(username.isEmpty){
      Fluttertoast.showToast(msg:"请输入账号");
      return;
    }
    if(password.isEmpty){
      Fluttertoast.showToast(msg:"请输入密码");
      return;
    }
    DioUtil.get("/users/huxiaofan1223",null).then((value) => {
      print(value)
    });
    print("登录了");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor("f7f7f7"),
      body: Center(
        child: Container(
          width:300,
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child:Image.asset(
                'images/logo.jpg',
                width:80,
                height:80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
                height:20
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(8),
                filled: true,
                fillColor: Colors.white,
                hintText: '请输入账号',
                hintStyle:TextStyle(color:HexColor("999999"),fontSize: 14)
              ),
              onChanged: _usernameChanged,
            ),
            SizedBox(
              height:20
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(10),
                filled: true,
                fillColor: Colors.white,
                hintText: '请输入密码',
                hintStyle:TextStyle(color:HexColor("999999"),fontSize: 14)
              ),
              onChanged: _passwordChanged,
            ),
            SizedBox(
                height:30
            ),
            SizedBox(
              width: double.infinity,
              height:42,
              child: RaisedButton(
                onPressed: login,
                child: Text("登录"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
