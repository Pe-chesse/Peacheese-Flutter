import 'package:dio/dio.dart';

class AccountAPI {
  final Dio _dio;

  AccountAPI(this._dio);

  Future verify() async {
    try {
      return await _dio.get('account/verify/');
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future getProfile(String user) async {
    try {
      return await _dio.get(
        'account/profile/',
        queryParameters: {
          'user': user,
        },
      );
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future updateProfile(String user) async {
    try {
      return await _dio.put(
        'account/profile/',
        data: {

        }
      );
    } on DioException catch (e) {
      return e.response;
    }
  }
}
