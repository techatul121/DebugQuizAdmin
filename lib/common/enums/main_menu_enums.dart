import '../../modules/category/views/category_view.dart';
import '../../modules/dashboard/views/dashboard_view.dart';

import '../../modules/notifications/views/notification_view.dart';

import '../../modules/questions/views/question_view.dart';
import '../../modules/quizes/views/quizes_view.dart';
import '../../modules/settings/views/settings_view.dart';

import '../constants/app_strings_constants.dart';
import '../constants/image_path_constants.dart';

enum MainMenuEnums {
  dashboard(
    title: AppStrings.dashboard,
    pathName: DashboardView.name,
    iconPath: SvgImages.dashboardIcon,
  ),

  notifications(
    title: AppStrings.notifications,
    pathName: NotificationView.name,
    iconPath: SvgImages.notificationIcon,
  ),
  category(
    title: AppStrings.category,
    pathName: CategoryView.name,
    iconPath: SvgImages.notificationIcon,
  ),
  quizes(
    title: AppStrings.quizes,
    pathName: QuizesView.name,
    iconPath: SvgImages.notificationIcon,
  ),
  questions(
    title: AppStrings.questions,
    pathName: QuestionView.name,
    iconPath: SvgImages.notificationIcon,
  ),
  settings(
    title: AppStrings.settings,
    pathName: SettingsView.name,
    iconPath: SvgImages.settingsIcon,
  ),
  logout(
    title: AppStrings.logout,
    pathName: '',
    iconPath: SvgImages.logoutIcon,
  );

  const MainMenuEnums({
    required this.title,
    required this.pathName,
    required this.iconPath,
  });

  final String title;
  final String pathName;
  final String iconPath;
}
