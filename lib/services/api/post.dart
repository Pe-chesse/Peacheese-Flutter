import 'package:dio/dio.dart';
import 'package:peach_market/models/post.dart';

class PostAPI {
  final Dio _dio;

  PostAPI(this._dio);

  Future getList() async {
    try {
      Response response = await _dio.get('post/');
      return response.data.map((e)=>Post.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response;
    }
  }
}