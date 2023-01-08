import 'package:feddit/core/constant/constant.dart';
import 'package:feddit/feature/authentication/controller/auth_controller.dart';
import 'package:feddit/feature/home/delegate/search_community_delegate.dart';
import 'package:feddit/feature/home/drawer/community_list_drawer.dart';
import 'package:feddit/feature/home/drawer/profile_drawer.dart';
import 'package:feddit/theme/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;
  void displayLeftDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayRightDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final currTheme = ref.watch(themeNotifierProvider);
    final isGuest = user.isGuest;

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
      body: Constant.tabWidgets[_page],
      drawer: const CommunityListDrawer(),
      endDrawer: isGuest ? null : const ProfileDrawer(),
      bottomNavigationBar: isGuest
          ? null
          : BottomNavigationBar(
              selectedItemColor: currTheme.iconTheme.color,
              backgroundColor: currTheme.backgroundColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: ' ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: ' ',
                ),
              ],
              onTap: onPageChanged,
              currentIndex: _page,
            ),
    );
  }
}
