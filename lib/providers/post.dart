import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/services/api.dart';

final postlistProvider =
    FutureProvider.autoDispose((ref) async => await API.post.getList());

final postDetailProvider =
    StateNotifierProvider.autoDispose<PostDetailNotifier, Post>((ref) {
  return PostDetailNotifier();
});

final imageKeyProvider = StateProvider((ref) => []);


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

final commentSelectProvider =
StateNotifierProvider.autoDispose<CommentSelectNotifier, Comment>((ref) {
  return CommentSelectNotifier();
});

class CommentSelectNotifier extends StateNotifier<Comment> {
  CommentSelectNotifier()
      : super(Comment(
            id: 0,
            body: '',
            user: User(email: ''),
            child_comments: [],
            updated_at: DateTime.now(),
            created_at: DateTime.now())); // 초기 상태 설정

  void select(Comment comment) {
    state = comment;
  }

  void init() {
    state = Comment(
        id: 0,
        body: '',
        user: User(email: ''),
        child_comments: [],
        updated_at: DateTime.now(),
        created_at: DateTime.now());
  }
}
