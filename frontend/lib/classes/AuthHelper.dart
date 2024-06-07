import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eunity/classes/RouteHandler.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  static String defaultHost = RouteHandler.defaultHost;

  //we should cache this value so that on app startup we go straight to main screens
  //and after isLoggedIn() is called, if it's false we log the user out
  static bool loggedIn = false;
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'openid', 'profile'],
    serverClientId:"473125180287-80hn1kcn8k3juut9p7ocvi6j77v9lnct.apps.googleusercontent.com"
  );


  static Future<bool> isLoggedIn() async {
    var sessionCookie = await readCookie('session_id');
    print('COOKIES!');
    print(sessionCookie);
    if (sessionCookie == null) {
      loggedIn = false;
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
        loggedIn = true;
        return true;
      } else {
        loggedIn = false;
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        loggedIn = false;
        return false;
      } else {
        loggedIn = false;
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

  static Future<void> signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
      //we want to sign out of google and our server and clear the session cookie
      googleSignIn.disconnect();
      String endPoint = '/users/logout';
      var url = '$defaultHost$endPoint';
      try {
        await RouteHandler.dio.post(
          url,
        );
        return;
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response!.data);
          return;
        } else {
          print('Unable to connect to server');
          return;
        }
      }
  }


  static Future<Response> verifyGoogleIDToken(String googleKey) async {
    String endPoint = '/auth/google?idToken=$googleKey';
    var url = '$defaultHost$endPoint';

    try {
      final response = await RouteHandler.dio.post(
        url,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return e.response!;
      } else {
        print('Unable to connect to server');
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
