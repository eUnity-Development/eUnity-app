import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eunity/classes/RouteHandler.dart';

class AuthHelper {
  static String defaultHost = RouteHandler.defaultHost;

  static Future<bool> isLoggedIn() async {
    var sessionCookie = await readCookie('session_id');
    print('COOKIES!');
    print(sessionCookie);
    if (sessionCookie == null) {
      return false;
    }

    //I want to make a request to the protected endpoint and check the response code
    String endPoint = '/users/me';
    var url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return false;
      } else {
        return false;
      }
    }
  }

  static readCookie(String key) async {
    String endPoint = '/users/login';
    var url = '$defaultHost$endPoint';
    Uri uri = Uri.parse(url);
    await RouteHandler.init();
    List<Cookie> cookies = await RouteHandler.cookieJar.loadForRequest(uri);
    for (var cookie in cookies) {
      if (cookie.name == key) {
        var decoded = Uri.decodeFull(cookie.value);
        return decoded;
      }
    }
  }

  static Future<Response> signUp(String email, String password) async {
    final params = {'email': email, 'password': password};
    final formData = FormData.fromMap(params);
    String endPoint = '/users/signup';
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

  static Future<Response> login(String email, String password) async {
    final params = {'email': email, 'password': password};
    final formData = FormData.fromMap(params);
    String endPoint = '/users/login';
    var url = '$defaultHost$endPoint';

    //this is the dio library making a post request
    try {
      final response = await RouteHandler.dio.post(
        url,
        data: formData,
      );
      return response;

      //on anything but a 200 response this code will run
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

  static Future<Response> googleSignIn() async {
    String endPoint = '/auth/google';
    var url = '$defaultHost$endPoint';
    //this is the dio library making a post request
    try {
      final response = await RouteHandler.dio.get(
        url,
      );
      return response;
      //on anything but a 200 response this code will run
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
