import 'dart:convert' show json;
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import'dart:developer';

const String client_id= "Iv1.fae2497876d1b3ce";
const String client_secret = "0d08ba12223f80a300cac6ac9327acec8299f2f2";

BaseOptions options = new BaseOptions(
    baseUrl: "https://api.github.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
);

class DioUtil{
    static Dio dio = new Dio(options);
    static Future request(method,url,dataMap)async{
        try{
            tokenInter();
            Response response;
            dio.options.headers[HttpHeaders.acceptHeader]="application/vnd.github.v3+json";
            dio.options.contentType = ContentType.parse("application/json").toString();
            response = method=="GET"?await dio.get(url,queryParameters:dataMap):await dio.post(url,data:dataMap);
            if(response.statusCode == 200){
                if(response.headers["content-type"][0].startsWith("application/json")){
                    return response.data;
                }
                else
                    return response.toString();
            }else{
                throw Exception("接口异常R");
            }
        }catch(e){
            print("网络出现错误${e}");
        }
    }
    static tokenInter(){
        dio.interceptors.add(InterceptorsWrapper(
            onRequest:(RequestOptions options){
                dio.lock();
                Future<dynamic> future = Future(()async{
                    SharedPreferences prefs =await SharedPreferences.getInstance();
                    var tokenString = prefs.getString("token");
                    var tokenJson = json.decode(tokenString);
                    return "token "+tokenJson["access_token"];
                });
                return future.then((value) {
                    print(value);
                    options.headers["Authorization"] = value;
                    return options;
                }).whenComplete(() => dio.unlock());
            },
            onResponse:(Response response) {
                return response;
            },
            onError: (DioError e) {
                return e;
            }
        ));
    }

    static Future get(url,dataMap)async{
        return request("GET",url,dataMap);
    }
    static Future post(url,dataMap)async{
        return request("POST",url,dataMap);
    }
}