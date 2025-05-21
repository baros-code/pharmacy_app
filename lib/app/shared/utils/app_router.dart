import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/pharmacy/presentation/pages/home_page.dart';
import '../presentation/error_page.dart';
import '../presentation/splash_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteConfig.splashRoute.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteConfig.splashRoute.path,
        name: RouteConfig.splashRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: SplashPage(), state: state);
        },
      ),

      GoRoute(
        path: RouteConfig.loginRoute.path,
        name: RouteConfig.loginRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: LoginPage(), state: state);
        },
        routes: [
          GoRoute(
            path: RouteConfig.signUpRoute.path,
            name: RouteConfig.signUpRoute.name,
            pageBuilder: (context, state) {
              return _buildPage(page: SignUpPage(), state: state);
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteConfig.homeRoute.path,
        name: RouteConfig.homeRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: HomePage(), state: state);
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return _buildPage(page: const ErrorPage(), state: state);
    },
  );

  static Page<Widget> _buildPage({
    required Widget page,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
              _buildTransition(animation, child),
      child: page,
    );
  }

  static Widget _buildTransition(Animation<double> animation, Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }
}

enum RouteConfig {
  splashRoute('/splash'),
  loginRoute('/login'),
  signUpRoute('/signup'),
  homeRoute('/home');

  const RouteConfig(this.path);

  final String path;

  String get name => path.replaceAll('/', '');
}
