import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/pharmacy/domain/entities/medication.dart';
import '../../features/pharmacy/presentation/cubit/pharmacy_cubit.dart';
import '../../features/pharmacy/presentation/pages/create_prescriptions_page.dart';
import '../../features/pharmacy/presentation/pages/home_page.dart';
import '../../features/pharmacy/presentation/pages/medication_details_page.dart';
import '../../features/pharmacy/presentation/pages/prescriptions_page.dart';
import '../presentation/pages/error_page.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/widgets/custom_nav_bar.dart';
import 'service_locator.dart';

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
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: kIsWeb ? null : const CustomBottomNavBar(),
            floatingActionButtonLocation:
                kIsWeb ? null : FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
                kIsWeb
                    ? null
                    : FloatingActionButton(
                      onPressed: () {
                        context.goNamed(
                          RouteConfig.createPrescriptionRoute.name,
                        );
                      },
                      shape: const CircleBorder(),
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        size: 32,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
          );
        },
        routes: [
          GoRoute(
            path: RouteConfig.homeRoute.path,
            name: RouteConfig.homeRoute.name,
            pageBuilder: (context, state) {
              return _buildPage(
                page: BlocProvider(
                  create: (context) => locator<PharmacyCubit>(),
                  child: HomePage(),
                ),
                state: state,
                isBottomNavPage: true,
              );
            },
            routes: [
              GoRoute(
                path: RouteConfig.medicationDetailsRoute.path,
                name: RouteConfig.medicationDetailsRoute.name,
                pageBuilder: (context, state) {
                  final medication = state.extra as Medication;
                  return _buildPage(
                    page: MedicationDetailsPage(medication),
                    state: state,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: RouteConfig.createPrescriptionRoute.path,
            name: RouteConfig.createPrescriptionRoute.name,
            pageBuilder: (context, state) {
              return _buildPage(
                page: CreatePrescriptionsPage(),
                state: state,
                isBottomNavPage: true,
              );
            },
          ),
          GoRoute(
            path: RouteConfig.prescriptionsRoute.path,
            name: RouteConfig.prescriptionsRoute.name,
            pageBuilder: (context, state) {
              return _buildPage(
                page: PrescriptionsPage(),
                state: state,
                isBottomNavPage: true,
              );
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return _buildPage(page: const ErrorPage(), state: state);
    },
  );

  static Page<Widget> _buildPage({
    required Widget page,
    required GoRouterState state,
    bool isBottomNavPage = false,
  }) {
    return isBottomNavPage
        ? NoTransitionPage(key: state.pageKey, child: page)
        : CustomTransitionPage(
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
  homeRoute('/home'),
  medicationDetailsRoute('/medication-details'),
  prescriptionsRoute('/prescriptions'),
  createPrescriptionRoute('/create-prescription');

  const RouteConfig(this.path);

  final String path;

  String get name => path.replaceAll('/', '');
}
