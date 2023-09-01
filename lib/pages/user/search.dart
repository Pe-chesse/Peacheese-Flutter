import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserSearchPage extends ConsumerWidget {
  UserSearchPage({super.key});

  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final serachState = ref.watch(searchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(30405060)),
          child: TextFormField(
            controller: editingController,
            onChanged: (value) async {
              if (value.length > 1) {
                ref.read(searchProvider.notifier).state = await API.account.search(value);
              }
            },
            autofocus: true,
            scrollPadding: const EdgeInsets.all(0),
            style: Theme.of(context).textTheme.bodySmall,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: serachState.length,
        itemBuilder: (context, index) => serachState.isEmpty?Container():ListTile(
          onTap: () => context.go('/profile/',extra: serachState[index].nickname),
          leading: UserProfileImageWidget(
            user: serachState[index],
          ),
          title: Text(serachState[index].nickname ?? '알 수 없음'),
        ),
      ),
    );
  }
}
