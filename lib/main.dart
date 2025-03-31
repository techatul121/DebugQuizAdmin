import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants/app_strings_constants.dart';
import 'common/theme/app_theme.dart';
import 'common/widgets/custom_screenutil.dart';
import 'routes/route_config.dart';
import 'services/local/local_storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return CustomScreenUtil(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: AppStrings.trendingHome,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,
          scrollBehavior: _CustomScrollBehavior(),
        );
      },
    );
  }
}

class _CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
