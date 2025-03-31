import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/category/views/category_view.dart';
import '../../modules/dashboard/views/dashboard_view.dart';

import '../../modules/login/views/login_view.dart';
import '../../modules/notifications/views/notification_view.dart';

import '../../modules/settings/views/settings_view.dart';

import '../route_config.dart';

final redirectScreenUtil = AutoDisposeNotifierProvider<_Notifier, void>(
  _Notifier.new,
);

class _Notifier extends AutoDisposeNotifier {
  @override
  build() {}

  GoRouter get _routerConfig => ref.read(routerProvider);

  void loginView() {
    _routerConfig.replaceNamed(LoginView.name);
  }

  void dashboardView() {
    _routerConfig.goNamed(DashboardView.name);
  }

  void categoryView() {
    _routerConfig.goNamed(CategoryView.name);
  }

  void notificationsView() {
    _routerConfig.goNamed(NotificationView.name);
  }

  void settingsView() {
    _routerConfig.goNamed(SettingsView.name);
  }
}
