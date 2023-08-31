import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/services/api.dart';

final postlistProvider =
    FutureProvider.autoDispose((ref) async => await API.post.getList());

final postDetailProvider = StateNotifierProvider.autoDispose<PostDetailNotifier, Post>((ref) {
  return PostDetailNotifier();
});

class PostDetailNotifier extends StateNotifier<Post> {
  PostDetailNotifier()
      : super(Post(
          id: 0,
          body: '',
          updated_at: DateTime.now(),
          created_at: DateTime.now(),
          is_like: false,
          like_length: 0,
          user: User(email: ''),
        )); // 초기 상태 설정

  Future<void> fetchPostDetail(int id) async {
    state = await API.post.getDetail(id);
  }
}
