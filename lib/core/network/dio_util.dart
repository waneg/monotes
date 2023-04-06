import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/toast_util.dart';
import '../../common/my_exception.dart';
import '../../common/storage_util.dart';

class DioUtils {
  //hym 100.65.145.188
  //真机 192.168.251.81
  //阿里云 http://47.120.1.145:8080
  static const String BASE_URL = "http://47.120.1.145:15689"; //base url
  static late DioUtils _instance;
  static const String TAG = "DIO";
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
        receiveTimeout: 60000,
        headers: {});

    //创建dio实例
    _dio = Dio(_baseOptions);

    //可根据项目需要选择性的添加请求拦截器
    _dio.interceptors.add(DioInterceptors());
  }

  /// get请求
  get(url, {data, options}) async {
    debugPrint('get request path ------$url-------请求参数$data');
    debugPrint('------------');
    late Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options);
      debugPrint('get result ---${response.data}');
      if (response.data["code"] != ResponseStatus.SUCCESS) {
        // 这里处理业务异常，具体异常处理在调用处处理
        throw MyException(response.data["msg"]);
      }
    } on DioError catch (e) {
      LogUtil.v('请求失败---错误类型${e.type}--错误信息${e.message}', tag: TAG);
      throw Exception(e.message);
    }

    return response;
  }

  /// Post请求
  post(url, {data, options}) async {
    print('post request path ------$url-------请求参数$data');
    late Response response;
    try {
      response = await _dio.post(url, data: data, options: options);
      print('post result ---${response.data}');
      if (response.data["code"] != ResponseStatus.SUCCESS) {
        // 这里处理业务异常，具体异常处理在调用处处理
        throw MyException(response.data["msg"]);
      }
    } on DioError catch (e) {
      print('请求失败---错误类型${e.type}--错误信息${e.message}');
      throw Exception(e.message);
    }

    return response;
  }

  /// Put请求
  put(url, {data, options}) async {
    print('post request path ------${url}-------请求参数${data}');
    late Response response;
    try {
      response = await _dio.put(url, data: data, options: options);
      print('post result ---${response.data}');
      if (response.data["code"] != ResponseStatus.SUCCESS) {
        // 这里处理业务异常，具体异常处理在调用处处理
        throw MyException(response.data["msg"]);
      }
    } on DioError catch (e) {
      //TODO TOAST提示用户
      print('请求失败---错误类型${e.type}--错误信息${e.message}');
      //  这里处理了错误可能同样涉及到业务异常，所以需要抛出异常，根据业务决定是否在调用处处理
      // 比如发送验证码，如果网络异常，提示用户无法连接到服务器，需要停止倒计时
      throw Exception(e.message);
    }

    return response;
  }

  /// Delete请求
  delete(url, {data, options}) async {
    print('post request path ------${url}-------请求参数${data}');
    late Response response;
    try {
      response = await _dio.delete(url, data: data, options: options);
      print('post result ---${response.data}');
      if (response.data["code"] != ResponseStatus.SUCCESS) {
        // 这里处理业务异常，具体异常处理在调用处处理
        throw MyException(response.data["msg"]);
      }
    } on DioError catch (e) {
      //TODO TOAST提示用户
      print('请求失败---错误类型${e.type}--错误信息${e.message}');
      //  这里处理了错误可能同样涉及到业务异常，所以需要抛出异常，根据业务决定是否在调用处处理
      // 比如发送验证码，如果网络异常，提示用户无法连接到服务器，需要停止倒计时
      throw Exception(e.message);
    }

    return response;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await StorageUtil.getToken()??"";
    if (token != "" && token.isNotEmpty) {
      // 头部添加token
      options.headers["token"] = token;
    }
    // 更多业务需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data["code"] == ResponseStatus.TOKEN_EX) {
      //这里处理token失效的情况，目前token有效期为30天，如果token失效，目前直接登出，重新登录，后期优化为刷新token
      // throw Exception(response.data["msg"]);
      //  await StorageUtil.removeToken();
      //  await StorageUtil.removeBoolItem("isLogin");
      //  清除token，退出登录，跳转登录页......
    }
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
          ToastUtil.showBasicToast("无法连接到服务器，请稍后重试");
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("无法连接到服务器，请稍后重试");
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
