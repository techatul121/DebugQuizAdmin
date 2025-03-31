import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../common/keys/key.dart';
import '../modules/base/views/base_view.dart';
import '../modules/category/views/category_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';

import '../modules/login/provider/auth_provider.dart';
import '../modules/login/states/auth_states.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifications/views/notification_view.dart';

import '../modules/settings/views/settings_view.dart';

import 'transition/page_transition.dart';

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    navigatorKey: AppKeys.navigatorKey,
    initialLocation: LoginView.path,
    debugLogDiagnostics: true,
    routes: [
      CustomGoRoute(
        path: LoginView.path,
        name: LoginView.name,
        pageBuilder: (_) => LoginView(),
      ),

      ShellRoute(
        pageBuilder: (context, state, child) {
          return PageTransition(
            key: state.pageKey,
            child: BaseView(child: child),
          );
        },
        routes: [
          CustomGoRoute(
            path: DashboardView.path,
            name: DashboardView.name,
            pageBuilder: (_) => const DashboardView(),
          ),
          CustomGoRoute(
            path: CategoryView.path,
            name: CategoryView.name,
            pageBuilder: (_) => const CategoryView(),
          ),

          CustomGoRoute(
            path: NotificationView.path,
            name: NotificationView.name,
            pageBuilder: (_) => const NotificationView(),
          ),

          CustomGoRoute(
            path: SettingsView.path,
            name: SettingsView.name,
            pageBuilder: (_) => const SettingsView(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final currentLocation = state.uri.path;
      if (authState is AuthenticatedState) {
        log('Authenticated to: ${state.uri.path}');
        if (currentLocation == LoginView.path) {
          return DashboardView.path;
        } else {
          return null;
        }
      } else if (authState is UnauthenticatedState) {
        log('Unauthenticated to: ${state.uri.path}');
        if (currentLocation == LoginView.path) {
          return null;
        } else {
          return LoginView.path;
        }
      } else {
        return null;
      }
    },
  );
});

class CustomGoRoute extends GoRoute {
  CustomGoRoute({
    required super.path,
    required super.name,
    required Widget Function(GoRouterState state) pageBuilder,
    super.redirect,
    super.parentNavigatorKey,
    super.routes,
  }) : super(
         pageBuilder: (context, state) {
           return PageTransition(key: state.pageKey, child: pageBuilder(state));
         },
       );
}
