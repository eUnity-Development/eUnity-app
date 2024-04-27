import 'package:dio/dio.dart';

class RouteHandler {
  static const defaultHost = "http://10.0.2.2:3000";
  static final dio = Dio();
  static bool started = false;

  static init() async {
    if (started) return;
    dio.options.connectTimeout = const Duration(seconds: 30);
    started = true;
  }
}
