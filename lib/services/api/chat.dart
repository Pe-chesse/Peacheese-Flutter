import 'package:dio/dio.dart';
import 'package:peach_market/models/chatroom.dart';

class ChatAPI {
  final Dio _dio;

  ChatAPI(this._dio);

  Future create(String nickname) async {
    try {
      Response response = await _dio.post('chat/create/',data: {'nickname':nickname});
      return Chatroom.fromJson(response.data);
    } on DioException catch (e) {
      return e.response;
    }
  }
}
