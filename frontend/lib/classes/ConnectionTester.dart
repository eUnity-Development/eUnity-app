import 'package:frontend/classes/RouteHandler.dart';
import 'package:dio/dio.dart';

class ConnectionTester {
  static String defaultHost = RouteHandler.defaultHost;

  static getTest() async {
    await RouteHandler.init();
    String endPoint = '/userInfo/';
    final url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(url);
      return response.data;
    } on DioException catch (e) {
      return Response(
        requestOptions: RequestOptions(path: url),
        data: {'message': e},
        statusCode: 500,
      );
    }
  }
}
