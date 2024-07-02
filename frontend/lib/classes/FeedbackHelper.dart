import 'package:eunity/classes/RouteHandler.dart';
import 'package:dio/dio.dart';

class FeedbackHelper {
  static String defaultHost = RouteHandler.defaultHost;

  static Future<Response> submitFeedback(
      int starRating, String positiveText, String negativeText) async {
    String userID = '2';
    final params = {
      'user': userID,
      'stars': starRating,
      'positive_message': positiveText,
      'negative_message': negativeText
    };
    final formData = FormData.fromMap(params);
    String endPoint = '/feedback/add';
    final url = '$defaultHost$endPoint';
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
