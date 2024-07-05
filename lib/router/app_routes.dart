import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/main_controller.dart';
import 'package:flutter_demo/screens/main_screen.dart';
import 'package:flutter_demo/screens/view/example.dart';
import 'package:flutter_demo/screens/view/flavors/flavors_list_screen.dart';
import 'package:flutter_demo/screens/view/todolist/todo_list_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          navigatorKey: rootNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (BuildContext context, GoRouterState state) {
                return MainController();
              },
            ),
            GoRoute(
              path: AppRoutes.main,
              builder: (BuildContext context, GoRouterState state) {
                return MainController();
              },
            ),
            GoRoute(
              path: AppRoutes.todo,
              builder: (BuildContext context, GoRouterState state) {
                return FlavorsListScreen(showAppBar: true);
              },
              parentNavigatorKey: rootNavigatorKey, // 确保使用根导航器
            ),
          ],
        );

  GoRouter getRouter() {
    return router;
  }
}

class AppRoutes {
  static const String home = '/';
  static const String main = '/home';
  static const String todo = '/todo';
}
