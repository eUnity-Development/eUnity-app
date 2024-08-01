import 'dart:convert';
import 'dart:io';
import 'package:eunity/classes/RouteHandler.dart';
import 'package:dio/dio.dart';

class UserInfoHelper {
  static String defaultHost = RouteHandler.defaultHost;
  static Map<dynamic, dynamic> tempCache = {};
  static Map<dynamic, dynamic> userInfoCache = {};

  static void loadDefaultCache() {
    userInfoCache['genderPreference'] = ['Women'];
    userInfoCache['relationshipType'] = 'Long Term Relationships';
    userInfoCache['userGender'] = '';
    userInfoCache['userGenderOptions'] = 'Non-Binary';
  }

  static void loadDefaultUserPrefsCache() {
    userInfoCache['pronouns'] = 'Add';
    userInfoCache['education'] = 'Add';
    userInfoCache['job'] = 'Add';
    userInfoCache['interests'] = [];
    userInfoCache['ethnicity'] = [];
    userInfoCache['politics'] = 'Add';
    userInfoCache['religion'] = [];
    userInfoCache['city'] = 'Edit';

    userInfoCache['exercise'] = 'Add';
    userInfoCache['drinking'] = 'Add';
    userInfoCache['cannabis'] = 'Add';
    userInfoCache['height'] = 'Add';
    userInfoCache['social-media'] = 'Add';
    userInfoCache['pets'] = 'Add';
    userInfoCache['diet'] = [];
  }
  
  static void clearTempCache() {
    tempCache = {};
  }

  static void loadDOBTempCache() {
    tempCache['userGender'] = '';
    tempCache['userGenderOptions'] = 'Non-Binary';
  }

  static Future<void> updateCacheVariable(
      String variable, String object, var newValue) async {
    if (object == '') {
      userInfoCache[variable] = newValue;
    } else {
      userInfoCache[object][variable] = newValue;
    }
  }

  static Future<void> emptyUserCache() async {
    userInfoCache = {};
  }

  static Future<Response> patchUserInfo() async {
    String endpoint = '/users/me';
    var url = '$defaultHost$endpoint';
    try {
      final response = await RouteHandler.dio.patch(
        url,
        data: jsonEncode(userInfoCache),
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

  static Future<Response> getUserInfo() async {
    String endPoint = '/users/me';
    var url = '$defaultHost$endPoint';
    try {
      final response = await RouteHandler.dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
      );
      userInfoCache = response.data;
      print(response.data);
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
      'image': await MultipartFile.fromFile(newImage.path),
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

  static String getImageURL(String imagePath) {
    String endPoint = '/media/user_image';
    List imageSplit = imagePath.split('/');
    String imageID = imageSplit[imageSplit.length - 1];
    var url = '$defaultHost$endPoint/$imageID';
    return url;
  }

  static String getPublicImageURL(String imagePath) {
    String endPoint = '/media/';
    List imageSplit = imagePath.split('/');
    String userID = imageSplit[imageSplit.length - 2];
    String imageID = imageSplit[imageSplit.length - 1];
    var url = '$defaultHost$endPoint$userID/$imageID';
    return url;
  }

  static Future<Response> getImage(String imagePath) async {
    String url = getImageURL(imagePath);
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

  static Future<Response> deleteImage(String imagePath) async {
    String url = getImageURL(imagePath);
    print(url);
    try {
      final response = await RouteHandler.dio.delete(url);
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
