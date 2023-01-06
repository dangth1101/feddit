import 'package:feddit/feature/authentication/screen/login_screen.dart';
import 'package:feddit/feature/community/screen/add_mod_screen.dart';
import 'package:feddit/feature/community/screen/community_screen.dart';
import 'package:feddit/feature/community/screen/create_community_screen.dart';
import 'package:feddit/feature/community/screen/edit_community_screen.dart';
import 'package:feddit/feature/community/screen/mod_tools_screen.dart';
import 'package:feddit/feature/home/screen/home_screen.dart';
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
  '/add-mod/:name': (routeData) => MaterialPage(
        child: AddModScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
});
