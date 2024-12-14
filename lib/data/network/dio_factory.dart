import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory{
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000;
    String language = await _appPreferences.getAppLanguage();
    String token = await _appPreferences.getToken();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "Bearer $token",
      DEFAULT_LANGUAGE: language
    };
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(milliseconds: _timeOut),
      receiveTimeout: Duration(milliseconds: _timeOut),
      headers: headers
    );

    if(kReleaseMode){
      print("release mode no logs");
    }else{
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true
      ));
    }
    return dio;
  }
}

class JsonResponseInterceptor extends Interceptor{
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic>? responseData;
    if (response.data is Map) {
      // Response type is Json
      responseData = response.data;
    } else {
      // Response type is Plain Text
      responseData = json.decode(response.data);
    }
    super.onResponse(responseData as Response, handler);
  }
}