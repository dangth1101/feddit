import 'package:feddit/core/constant/constant.dart';
import 'package:feddit/feature/authentication/controller/auth_controller.dart';
import 'package:feddit/feature/home/delegate/search_community_delegate.dart';
import 'package:feddit/feature/home/drawer/community_list_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
            splashRadius: Constant.defaultSplashRadius,
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
            splashRadius: 20,
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
            ),
            onPressed: () {},
            splashRadius: 20,
          )
        ],
      ),
      body: Center(
        child: Text(user.name),
      ),
      drawer: const CommunityListDrawer(),
    );
  }
}
