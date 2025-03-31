class ApiEndpoints {
  static const String server = 'https://backend.trendinghomes.in/api/v1';
  static const String fileBaseUrl = 'https://backend.trendinghomes.in';

  static String projectNotification(int projectId) =>
      '/project/$projectId/notification';
  static const String addNews = '/news/add';

  static String newsDetails(int newsId) => '/news/$newsId/details';

  static String updateNews(int newsId) => '/news/$newsId/details';

  /// Auth
  static const String login = '/auth/admin/login';

  static const String verifyOtp = '/auth/admin/verify/otp';

  static const String refreshToken = '/auth/refresh/token';

  static const String cleanCache = '/cache/clear-cache';
}
