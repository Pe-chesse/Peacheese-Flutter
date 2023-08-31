import 'package:dio/dio.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/models/user.dart';

class AccountAPI {
  final Dio _dio;

  AccountAPI(this._dio);

  Future verify() async {
    try {
      Response response = await _dio.get('account/verify/');
      return User.fromJson(response.data);
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
        'post': response.data['post'].map((e)=>Post.fromJson(e)).toList()
      };
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
