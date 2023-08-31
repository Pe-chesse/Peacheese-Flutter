import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peach_market/models/post.dart';

class BucketAPI {
  final Dio _dio;

  BucketAPI(this._dio);

  Future upload(List<XFile> images) async {
    try {
      List<MultipartFile> multipartImages = await Future.wait(
        images.map(
          (e) async => MultipartFile.fromFile(
            File(e.path).path,
            filename: e.name,
          ),
        ),
      );

      FormData formData = FormData.fromMap({
        'files': multipartImages.where((element) => element != null).toList(),
      });

      return await _dio.post('bucket/media/', data: formData);
    } on DioException catch (e) {
      return e.response;
    }
  }
}
