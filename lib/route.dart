import 'package:feddit/feature/authentication/screen/login_screen.dart';
import 'package:feddit/feature/community/screen/add_mod_screen.dart';
import 'package:feddit/feature/community/screen/community_screen.dart';
import 'package:feddit/feature/community/screen/create_community_screen.dart';
import 'package:feddit/feature/community/screen/edit_community_screen.dart';
import 'package:feddit/feature/community/screen/mod_tools_screen.dart';
import 'package:feddit/feature/home/screen/home_screen.dart';
import 'package:feddit/feature/post/screen/add_post_type_screen.dart';
import 'package:feddit/feature/post/screen/comment_screen.dart';
import 'package:feddit/feature/user_profile/screen/edit_user_profiile_screen.dart';
import 'package:feddit/feature/user_profile/screen/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final logOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final logInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/u/:uid': (route) => MaterialPage(
        child: UserProfileScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-user-profile/:uid': (routeData) => MaterialPage(
        child: EditUserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/add-mod/:name': (routeData) => MaterialPage(
        child: AddModScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/add-post/:type': (routeData) => MaterialPage(
        child: AddPostTypeScreen(
          type: routeData.pathParameters['type']!,
        ),
      ),
  '/post/:postId/comments': (routeData) => MaterialPage(
        child: CommentScreen(
          postId: routeData.pathParameters['postId']!,
        ),
      ),
});
