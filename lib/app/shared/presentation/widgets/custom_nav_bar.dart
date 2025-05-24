import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(
            context,
            icon: Icons.home,
            label: 'Home',
            route: RouteConfig.homeRoute.name,
            selected: location.startsWith(RouteConfig.homeRoute.path),
          ),
          const SizedBox(width: 48),
          _buildTabItem(
            context,
            icon: Icons.medical_services,
            label: 'Prescriptions',
            route: RouteConfig.prescriptionsRoute.name,
            selected: location.startsWith(RouteConfig.prescriptionsRoute.path),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: () => context.goNamed(route),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color:
                selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  selected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
