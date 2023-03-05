import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'storage_util.dart';

class DioUtils {
  static const String BASE_URL = "http://100.65.223.206:8080"; //base url
  static late DioUtils _instance;
  late Dio _dio;
  late BaseOptions _baseOptions;

  static DioUtils getInstance() {
    if (_instance == null) {
      _instance = new DioUtils();
    }
    return _instance;
  }

  /// dio初始化配置
  DioUtils() {
    //请求参数配置
    _baseOptions = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {});

    //创建dio实例
    _dio = Dio(_baseOptions);

    //可根据项目需要选择性的添加请求拦截器
    _dio.interceptors.add(DioInterceptors());
  }

  /// get请求
  get(url, {data, options}) async {
    print('get request path ------${url}-------请求参数${data}');
    print('------------');
    late Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options);
      debugPrint('get result ---${response.data}');
    } on DioError catch (e) {
      print('请求失败---错误类型${e.type}--错误信息${e.message}');
    }

    return response;
  }

  /// Post请求
  post(url, {data, options}) async {
    print('post request path ------${url}-------请求参数${data}');
    late Response response;
    try {
      response = await _dio.post(url, data: data, options: options);
      print('post result ---${response.data}');
    } on DioError catch (e) {
      print('请求失败---错误类型${e.type}--错误信息${e.message}');
    }

    return response;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await StorageUtil.getToken();
    if (token != null) {
      // 头部添加token
      options.headers["token"] = token.toString();
    }
    // 更多业务需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 重点
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      // 连接服务器超时
      case DioErrorType.connectTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 发送超时
      case DioErrorType.sendTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 请求取消
      case DioErrorType.cancel:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // 404/503错误
      case DioErrorType.response:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        }
        break;
      // other 其他错误类型
      case DioErrorType.other:
        {}
        break;
    }
    super.onError(err, handler);
  }
}
