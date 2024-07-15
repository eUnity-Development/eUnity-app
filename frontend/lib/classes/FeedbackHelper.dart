import 'dart:convert';

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

  static Future<Response> getIssueReport() async {
    String endPoint = '/report_issue/get_report';
    final url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(
        url,
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

  static Future<Response> AddIssueReport(
      String description, String email) async {
    String endPoint = '/report_issue/add_report';
    final url = '$defaultHost$endPoint';
    final params = {'description': description, 'email': email};
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

  static Future<Response> updateIssueReport(
      Map<dynamic, dynamic> newData) async {
    String endpoint = '/report_issue/update_report';
    var url = '$defaultHost$endpoint';
    try {
      final response = await RouteHandler.dio.patch(
        url,
        data: jsonEncode(newData),
      );
      return response;
    } on DioException catch (e) {
      print('update issue error');
      print(e);
      return Response(
        requestOptions: RequestOptions(path: url),
        data: {'message': 'Unable to connect to server'},
        statusCode: 500,
        statusMessage: 'Unable to connect to server',
      );
    }
  }

  static Future<Response> submitIssueReport() async {
    String endpoint = '/report_issue/submit_report';
    var url = '$defaultHost$endpoint';
    try {
      final response = await RouteHandler.dio.patch(
        url,
      );
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
