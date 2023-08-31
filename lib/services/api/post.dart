import 'package:dio/dio.dart';
import 'package:peach_market/models/post.dart';

class PostAPI {
  final Dio _dio;

  PostAPI(this._dio);

  Future getList() async {
    try {
      Response response = await _dio.get('post/');
      return response.data.map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future getDetail(int id) async {
    try {
      Response response = await _dio.get('post/$id/');
      Post result = Post.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future writePost(String body, List imageKey) async {
    try {
      Response response = await _dio.post('post/', data: {
        'body': body,
        if (imageKey.isNotEmpty) 'image_keys': imageKey
      });
      return response.data['id'];
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future writeComment(int postId, String body) async {
    try {
      Response response =
          await _dio.post('post/$postId/', data: {'body': body});
      return response.statusCode == 201;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future reWriteComment(int commentId, String body) async {
    try {
      Response response =
          await _dio.post('post/comment/$commentId/', data: {'body': body});
      return response.statusCode == 201;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future like(int postId) async {
    try {
      return await _dio.post('post/like/', data: {'post': postId});
    } on DioException catch (e) {
      return e.response;
    }
  }
}
