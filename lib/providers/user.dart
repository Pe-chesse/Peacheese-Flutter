
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/services/api.dart';

final userprofileProvider =
FutureProvider.autoDispose.family((ref,String user) async=> await API.account.getProfile(user));

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(email: 'unknown'));

  void set(User user) => state = user;

  Future get()async=> state = await API.account.verify();

}
final evaluateWriteProvider =
StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());