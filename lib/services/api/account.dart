import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/models/user.dart';

class AccountAPI {
  final Dio _dio;

  AccountAPI(this._dio);

  Future verify() async {
    try {
      Response response = await _dio.get('account/verify/',
          options: Options(headers: {
            'Fcmtoken': 'Bearer ${await FirebaseMessaging.instance.getToken()}'
          }));
      return User.fromJson(response.data);
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future search(String nickname) async {
    try {
      Response response = await _dio.get(
        'account/search/?user=$nickname',
      );
      return response.data.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future getProfile(String user) async {
    try {
      Response response = await _dio.get(
        'account/profile/?user=$user',
      );
      return {
        'user': User.fromJson(response.data['user']),
        'post': response.data['post'].map((e) => Post.fromJson(e)).toList()
      };
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future getFollow(String nickname, bool follow) async {
    try {
      Response response = await _dio.get(
        'account/follow/$nickname/?f=${follow ? '' : 'false'}',
      );
      return response.data.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future setFollow(String nickname) async {
    try {
      Response response = await _dio.post(
        'account/follow/$nickname/',
      );
      return response.data.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future editProfile(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put('account/profile/', data: data);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future updateProfile(String user) async {
    try {
      return await _dio.put('account/profile/', data: {});
    } on DioException catch (e) {
      return e.response;
    }
  }
}
