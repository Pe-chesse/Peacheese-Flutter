// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peach_market/services/api/account.dart';
import 'package:peach_market/services/api/bucket.dart';
import 'package:peach_market/services/api/chat.dart';
import 'package:peach_market/services/api/post.dart';

class API{
  static String BASE_ADDRESS = '3.37.239.49';
  static String BASE_URL = 'http://$BASE_ADDRESS/api/v1/';
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL
  ));

  static Dio get dio {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async{
        options.headers['Authorization'] = await FirebaseAuth.instance.currentUser?.getIdToken()??'';
        return handler.next(options);
      },
    ));
    return _dio;
  }

  static final AccountAPI account = AccountAPI(API.dio);
  static final BucketAPI bucket = BucketAPI(API.dio);
  static final ChatAPI chat = ChatAPI(API.dio);
  static final PostAPI post = PostAPI(API.dio);
}
