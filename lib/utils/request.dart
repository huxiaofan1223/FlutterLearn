import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

const String client_id = "0d08ba12223f80a300cac6ac9327acec8299f2f2";
const String client_secret= "Iv1.fae2497876d1b3ce";

BaseOptions options = new BaseOptions(
    baseUrl: "https://api.github.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {HttpHeaders.acceptHeader: "accept: application/json"},
);

class DioUtil{
    static Dio dio = new Dio(options);
    static Future request(method,url,dataMap)async{
        try{
            Response response;
            dio.options.contentType = ContentType.parse("application/vnd.github.v3+json").toString();
            response = method=="GET"?await dio.get(url,queryParameters:dataMap):await dio.post(url,data:dataMap);
            if(response.statusCode == 200){
                return response;
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
                    return prefs.getString("token");
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