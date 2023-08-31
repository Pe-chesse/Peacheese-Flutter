
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/services/api.dart';

final postlistProvider =
FutureProvider.autoDispose((ref) async => await API.post.getList());
