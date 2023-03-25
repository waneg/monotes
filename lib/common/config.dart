import 'dart:ui';

class ThemeColor {
  static var pageColor = const Color.fromRGBO(241, 243, 240, 1);
  static var conclusionBgColor = const Color.fromRGBO(221, 240, 238, 1);
  static var appBarColor = const Color(0xFF4095E5);
  static var bgColor = const Color(0xFFEFEFEF);
}

const String TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxIiwiZXhwIjoxNjgwMzU2NDAwfQ.P2S1L1oYIkurEuAVszaQgIAJ1sXkRfiSwLN55gk_M4g";

const SHOPPING_TYPE = {
  1: "餐饮美食",
  2: "服饰装扮",
  3: "日用",
  4: "家居家装",
  5: "数码电器",
  6: "运动户外",
  7: "美容美发",
  8: "母婴亲子",
  9: "宠物",
  10: "交通出行",
  11: "爱车养车",
  12: "住房物业",
  13: "酒店旅游",
  14: "文化休闲",
  15: "教育培训",
  16: "医疗健康",
  17: "公益捐赠",
  18: "投资理财",
  19: "信用借还",
  20: "充值缴费",
  21: "收入",
  22: "亲友",
  23: "其他",
};

class ResponseStatus{
  static int SUCCESS = 0; ///响应成功
  static int LOGIN_FAIL = 100; ///登录失败，用户名或密码错误
  static int CODE_FAIL = 101; ///获取验证码失败，服务器未能发送验证码，请稍后再试
  static int PHONE_ERROR = 102; ///手机号码格式错误,请修改后重新获取验证码
  static int SET_PASSWORD_FAIL = 110; ///设置密码失败，请稍后再试
  static int SET_PASSWORD_NOT_ALLOW = 111; ///超时未设置密码，已失效，请重新获取验证码
  static int FAIL = 201; ///获取数据失败
  static int NO_TOKEN = 400; ///无token，请重新登录
  static int TOKEN_EX = 401; ///token验证失败，可能已过期，请重新登录
  static int USER_EX = 402; ///用户不存在，请重新登录
}