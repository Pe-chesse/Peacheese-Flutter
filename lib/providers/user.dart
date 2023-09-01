import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/services/api.dart';

final userProfileProvider = FutureProvider.family(
        (ref, String user) async => await API.account.getProfile(user));

final userFollowProvider = FutureProvider.autoDispose.family(
        (ref, (String, bool) option) async =>
    await API.account.getFollow(option.$1, option.$2));

final searchProvider = StateProvider.autoDispose((ref) => []);

final myFollowProvider = StateProvider.autoDispose((ref) => []);

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(email: 'unknown'));

  void set(User user) => state = user;

  Future get() async => state = await API.account.verify();
}

final userStateNotifierProvider =
StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
