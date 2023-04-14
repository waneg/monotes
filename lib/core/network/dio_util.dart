import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:monotes/common/config.dart';
import 'package:monotes/common/toast_util.dart';

import '../../common/my_exception.dart';
import '../../common/storage_util.dart';

/// Dio网络请求工具类
/// 封装了get、post、put、delete请求
/// 调用时必须Catch MyException处理业务相关错误
/// 例如获取验证码失败，需要处理倒计时，有loading的页面需要关闭loading
/// 部分Catch MyException的地方不需要任何操作，只是为了防止程序崩溃
class DioUtils {
  //hym 100.65.145.188
  //真机 192.168.251.81
  //阿里云 http://47.101.136.247/api
  static const String BASE_URL = "http://47.101.136.247/api"; //base url
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
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {});

    //创建dio实例
    _dio = Dio(_baseOptions);

    //可根据项目需要选择性的添加请求拦截器
    _dio.interceptors.add(DioInterceptors());
  }

  /// get请求
  get(url, {data, options}) async {
    debugPrint('get request path ------$url-------请求参数$data');
    late Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options);
      debugPrint('get result ---${response.data}');
      return response;
    } on DioError catch (e) {
      //统一异常处理，DioError错误在MyException中code为-1
      debugPrint('请求失败---错误类型${e.type}--错误信息${e.message}--error信息${e.error}');
      throw MyException(
          msg: e.message == null ? "" : e.message!,
          code: e.error is int ? e.error as int : -1);
    }
  }

  /// Post请求
  Future<Response> post(url, {data, options}) async {
    // debugPrint('post request path ------$url-------请求参数$data');
    // late Response response;
    // _dio.post(url, data: data, options: options).then((value) {
    //   debugPrint('post result ---${value.data}');
    //   return value;
    // }).catchError((e) {
    //   //统一异常处理，DioError错误在MyException中code为-1
    //   debugPrint('请求失败---错误类型${e.type}--错误信息${e.message}');
    //   throw MyException(msg: e.message == null ? "" : e.message!);
    // });
    late Response response;
    try {
      response = await _dio.post(url, data: data, options: options);
      debugPrint('post result ---${response.data}');
      return response;
    } on DioError catch (e) {
      //统一异常处理，DioError错误在MyException中code为-1
      debugPrint('请求失败---错误类型${e.type}--错误信息${e.message}--error信息${e.error}');
      throw MyException(
          msg: e.message == null ? "" : e.message!,
          code: e.error is int ? e.error as int : -1);
    }
  }

  /// Put请求
  put(url, {data, options}) async {
    debugPrint('post request path ------${url}-------请求参数${data}');
    late Response response;
    try {
      response = await _dio.put(url, data: data, options: options);
      debugPrint('post result ---${response.data}');
      return response;
    } on DioError catch (e) {
      //统一异常处理，DioError错误在MyException中code为-1
      debugPrint('请求失败---错误类型${e.type}--错误信息${e.message}--error信息${e.error}');
      throw MyException(
          msg: e.message == null ? "" : e.message!,
          code: e.error is int ? e.error as int : -1);
    }
  }

  /// Delete请求
  delete(url, {data, options}) async {
    debugPrint('post request path ------${url}-------请求参数${data}');
    late Response response;
    try {
      response = await _dio.delete(url, data: data, options: options);
      debugPrint('post result ---${response.data}');
      return response;
    } on DioError catch (e) {
      //统一异常处理，DioError错误在MyException中code为-1
      debugPrint('请求失败---错误类型${e.type}--错误信息${e.message}--error信息${e.error}');
      throw MyException(
          msg: e.message == null ? "" : e.message!,
          code: e.error is int ? e.error as int : -1);
    }
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await StorageUtil.getToken() ?? "";
    if (token != "" && token.isNotEmpty) {
      // 头部添加token
      options.headers["token"] = token;
    }
    // 更多业务需求
    return handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data["code"] == ResponseStatus.TOKEN_EX ||
        response.data["code"] == ResponseStatus.NO_TOKEN ||
        response.data["code"] == ResponseStatus.USER_EX) {
      //这里处理token失效的情况，目前token有效期为30天，如果token失效，目前直接登出，重新登录，后期优化为刷新token
      //  清除token，退出登录，跳转登录页......
      Get.offAllNamed("/code_login_step_one");
      StorageUtil.clear();
      ToastUtil.showBasicToast(
          "${response.data["code"]}: ${response.data["msg"]}");
      return handler.reject(DioError(
          requestOptions: response.requestOptions,
          error: response.data["code"],
          message: response.data["msg"]));
      // handler.reject(DioError(
      //     requestOptions: response.requestOptions,
      //     error: response.data["code"],
      //     message: response.data["msg"]));
      // throw MyException(msg: response.data["msg"], code: response.data["code"]);
    }
    // 重点
    if (response.data["code"] != ResponseStatus.SUCCESS) {
      ToastUtil.showBasicToast(
          "${response.data["code"]}: ${response.data["msg"]}");
      return handler.reject(DioError(
          requestOptions: response.requestOptions,
          error: response.data["code"],
          message: response.data["msg"]));
      // throw MyException(msg: response.data["msg"], code: response.data["code"]);
    }
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      // 连接服务器超时
      case DioErrorType.connectionTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("连接服务器超时，请稍后重试");
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("响应超时，请稍后重试");
        }
        break;
      // 发送超时
      case DioErrorType.sendTimeout:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("发送超时，请稍后重试");
        }
        break;
      // 请求取消
      case DioErrorType.cancel:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("请求取消");
        }
        break;
      // 404/503错误
      case DioErrorType.badResponse:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast(
              "服务器响应错误，HttpStatusCode: ${err.response?.statusCode}");
        }
        break;
      // other 其他错误类型
      default:
        {
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          ToastUtil.showBasicToast("请求失败，请稍后重试");
        }
        break;
    }
    return handler.reject(err);
  }
}
