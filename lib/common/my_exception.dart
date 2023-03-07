/// Dart 语言提供了Exception和Error类型，以及许多预定义的子类类型
/// 也可以自定义异常，Error是程序无法恢复的严重错误，表示程序出现
/// 较严重问题，而又无法通过编程处理，只能终止程序
///
/// 使用try语句来捕获异常，catch语句处理异常，catch语句有两个参数
/// 一个必选的异常对象，第二个是可选的堆栈对象
///

// 自定义异常
class MyException implements Exception {
  // 接收异常信息
  final String msg;

  MyException(this.msg);

  // 覆写toString方法
  @override
  String toString() {
    // TODO: implement toString
    return msg ?? 'MyException:$msg';
  }
}
