import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/constants/image_path_constants.dart';
import '../../../common/enums/main_menu_enums.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../../routes/utils/redirect_utils.dart';
import '../../category/views/category_view.dart';
import '../../dashboard/views/dashboard_view.dart';

import '../../notifications/views/notification_view.dart';

import '../../settings/views/settings_view.dart';

import 'desktop/custom_menu_tile.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.path;
    return Container(
      margin: EdgeInsets.zero,
      padding: AppEdgeInsets.h20,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: AppBorderRadius.tr30Br30,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: AppSize.size25,
            offset: const Offset(5, 5),
            color: AppColors.black.withValues(alpha: 0.4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SBH30(),
          const Padding(
            padding: AppEdgeInsets.h15,
            child: Text28W400(AppStrings.adminPanel, color: AppColors.white),
          ),
          const SBH40(),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  spacing: AppSize.size10,
                  children: [
                    CustomMenuTile(
                      title: MainMenuEnums.dashboard.title,
                      iconPath: MainMenuEnums.dashboard.iconPath,
                      isSelected: currentPath == DashboardView.path,
                      onTap: () {
                        ref.read(redirectScreenUtil.notifier).dashboardView();
                      },
                    ),
                    CustomMenuTile(
                      title: MainMenuEnums.category.title,
                      iconPath: MainMenuEnums.dashboard.iconPath,
                      isSelected: currentPath == CategoryView.path,
                      onTap: () {
                        ref.read(redirectScreenUtil.notifier).categoryView();
                      },
                    ),
                    CustomMenuTile(
                      title: MainMenuEnums.notifications.title,
                      iconPath: MainMenuEnums.notifications.iconPath,
                      isSelected: currentPath == NotificationView.path,
                      onTap: () {
                        ref
                            .read(redirectScreenUtil.notifier)
                            .notificationsView();
                      },
                    ),

                    CustomMenuTile(
                      title: MainMenuEnums.settings.title,
                      iconPath: MainMenuEnums.settings.iconPath,
                      isSelected: currentPath == SettingsView.path,
                      onTap: () {
                        ref.read(redirectScreenUtil.notifier).settingsView();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          const CustomMenuTile(
            title: AppStrings.admin,
            hover: false,
            iconPath: SvgImages.userIcon,
          ),

          Consumer(
            builder: (context, ref, child) {
              return CustomMenuTile(
                title: MainMenuEnums.logout.title,
                iconPath: MainMenuEnums.logout.iconPath,
                onTap: () {
                  CustomDialog.confirmDialog(
                    message: AppStrings.logoutConfirmation,
                    onConfirm: () {
                      //  ref.read(authProvider.notifier).deAuthenticate();
                    },
                  );
                },
              );
            },
          ),
          const SBH10(),
          const Padding(
            padding: AppEdgeInsets.l15,
            child: Text16W500(
              '${AppStrings.version} ${AppStrings.versionNo}',
              color: AppColors.white,
            ),
          ),
          const SBH20(),
        ],
      ),
    );
  }
}
