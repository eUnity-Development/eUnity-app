import 'dart:io';
import 'package:eunity/classes/RouteHandler.dart';
import 'package:dio/dio.dart';

class UserInfoHelper {
  static String defaultHost = RouteHandler.defaultHost;

  static Future<Response> getUserInfo() async {
    String endPoint = '/users/me';
    var url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
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

  static Future<Response> uploadNewImage(File newImage) async {
    String endPoint = '/media/user_image';
    var url = '$defaultHost$endPoint';
    var formData = FormData.fromMap({
      'photo':
          await MultipartFile.fromFile(newImage.path, filename: "New Photo"),
    });
    try {
      final response = await RouteHandler.dio.post(url,
          data: formData,
          options: Options(contentType: Headers.multipartFormDataContentType));
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

  static Future<Response> getImage(String imagePath) async {
    String endPoint = '/media/user_image';
    List imageSplit = imagePath.split('/');
    String imageID = imageSplit[imageSplit.length - 1];
    var url = '$defaultHost$endPoint/$imageID';
    print(url);
    try {
      final response = await RouteHandler.dio.get(url);
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
