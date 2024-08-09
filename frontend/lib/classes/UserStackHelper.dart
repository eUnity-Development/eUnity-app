import 'package:dio/dio.dart';
import 'package:eunity/classes/RouteHandler.dart';

class UserStackHelper {
  static String defaultHost = RouteHandler.defaultHost;
  static Map<dynamic, dynamic> tempCache = {};
  static List<dynamic> userStackCache = [];

  static void clearTempCache() {
    tempCache = {};
  }

  static Future<Response> getUserStack() async {
    String endPoint = '/users/get_users';
    var url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
      );
      userStackCache = response.data;
      return response;
    } on DioException catch (e) {
      print(e);
      return Response(
        requestOptions: RequestOptions(path: url),
        data: {'message': 'Unable to connect to server'},
        statusCode: 500,
        statusMessage: 'Unable to connect to server',
      );
    }
  }
}