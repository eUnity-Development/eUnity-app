import 'package:dio/dio.dart';
import 'package:eunity/classes/RouteHandler.dart';

class SwipeHelper {
  static String defaultHost = RouteHandler.defaultHost;

  static Future<Response> addUserSwipe(String swipedUser, bool swipedDirection) async {
    String endPoint = '/swipe/add_swipe';
    final url = '$defaultHost$endPoint';
    final params = {
      'swiped_user': swipedUser,
      'swiped_direction': swipedDirection,
    };
    final formData = FormData.fromMap(params);

    try {
      final response = await RouteHandler.dio.post(
        url,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        return Response(
          requestOptions: RequestOptions(path: url),
          data: {'message': 'Unable to connect to server'},
          statusCode: 500,
          statusMessage: 'Unable to connect to server',
        );
      }
    }
  }
}
