import 'package:feddit/core/constant/constant.dart';
import 'package:feddit/feature/authentication/controller/auth_controller.dart';
import 'package:feddit/feature/home/delegate/search_community_delegate.dart';
import 'package:feddit/feature/home/drawer/community_list_drawer.dart';
import 'package:feddit/feature/home/drawer/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayLeftDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayRightDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
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
            onPressed: () => displayLeftDrawer(context),
            splashRadius: Constant.defaultSplashRadius,
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchCommunityDelegate(ref),
              );
            },
            icon: const Icon(Icons.search),
            splashRadius: Constant.defaultSplashRadius,
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                onPressed: () => displayRightDrawer(context),
                splashRadius: Constant.defaultSplashRadius,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text(user.name),
      ),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
    );
  }
}
