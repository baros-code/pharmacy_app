import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/pharmacy/domain/entities/medication.dart';
import '../../features/pharmacy/domain/entities/prescription.dart';
import '../../features/pharmacy/presentation/pages/create_prescriptions_page.dart';
import '../../features/pharmacy/presentation/pages/home_page.dart';
import '../../features/pharmacy/presentation/pages/medication_details_page.dart';
import '../../features/pharmacy/presentation/pages/prescription_details_page.dart';
import '../../features/pharmacy/presentation/pages/prescriptions_page.dart';
import '../presentation/pages/error_page.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/widgets/custom_nav_bar.dart';

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
          // Web navigation with NavigationRail
          if (kIsWeb) {
            return Scaffold(
              body: Row(
                children: [
                  // Web navigation on the left
                  NavigationRail(
                    selectedIndex: _getSelectedIndex(context),
                    onDestinationSelected: (index) {
                      final route = _getRouteByIndex(index);
                      if (route != null) {
                        context.goNamed(route);
                      }
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.description_outlined),
                        selectedIcon: Icon(Icons.description),
                        label: Text('Prescriptions'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.add_outlined),
                        selectedIcon: Icon(Icons.add),
                        label: Text('Create'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  // Main content
                  Expanded(child: child),
                ],
              ),
            );
          }
          // Mobile navigation with bottom nav bar
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
                page: HomePage(),
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
            routes: [
              GoRoute(
                path: RouteConfig.prescriptionDetailsRoute.path,
                name: RouteConfig.prescriptionDetailsRoute.name,
                pageBuilder: (context, state) {
                  final prescription = state.extra as Prescription;
                  return _buildPage(
                    page: PrescriptionDetailsPage(prescription),
                    state: state,
                  );
                },
              ),
            ],
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

  static int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(RouteConfig.homeRoute.path)) return 0;
    if (location.startsWith(RouteConfig.prescriptionsRoute.path)) return 1;
    if (location.startsWith(RouteConfig.createPrescriptionRoute.path)) return 2;
    return 0;
  }

  static String? _getRouteByIndex(int index) {
    switch (index) {
      case 0:
        return RouteConfig.homeRoute.name;
      case 1:
        return RouteConfig.prescriptionsRoute.name;
      case 2:
        return RouteConfig.createPrescriptionRoute.name;
      default:
        return null;
    }
  }
}

enum RouteConfig {
  splashRoute('/splash'),
  loginRoute('/login'),
  signUpRoute('/signup'),
  homeRoute('/home'),
  medicationDetailsRoute('/medication-details'),
  prescriptionsRoute('/prescriptions'),
  createPrescriptionRoute('/create-prescription'),
  prescriptionDetailsRoute('/prescription-details');

  const RouteConfig(this.path);

  final String path;

  String get name => path.replaceAll('/', '');
}
