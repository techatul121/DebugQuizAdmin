import '../constants/app_strings_constants.dart';
import '../utils/custom_toast.dart';

extension ValidationExtensions on String {
  bool isValid(String title) {
    if (isEmpty) {
      CustomToast.showError('$title ${AppStrings.canNotBeEmpty}');
      return false;
    } else {
      return true;
    }
  }

  bool isValidOtp() {
    if (isEmpty) {
      CustomToast.showError('${AppStrings.otp} ${AppStrings.canNotBeEmpty}');
      return false;
    } else if (length < 6) {
      CustomToast.showError('${AppStrings.otp} ${AppStrings.invalid}');
      return false;
    } else {
      return true;
    }
  }

  bool isEmail() {
    if (isEmpty) {
      CustomToast.showError('${AppStrings.email} ${AppStrings.canNotBeEmpty}');
      return false;
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$',
    ).hasMatch(this)) {
      CustomToast.showError('${AppStrings.email} ${AppStrings.invalid}');
      return false;
    } else {
      return true;
    }
  }

  bool isValidYouTubeUrl() {
    if (isEmpty) {
      CustomToast.showError(
        '${AppStrings.youtubeVideoUrl} ${AppStrings.canNotBeEmpty}',
      );
      return false;
    }

    // YouTube URL Regex Pattern (Supports full & short URLs)
    final youtubeRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)([\w-]+)',
    );

    if (!youtubeRegex.hasMatch(this)) {
      CustomToast.showError(
        '${AppStrings.youtubeVideoUrl} ${AppStrings.invalid}',
      );
      return false;
    }

    return true;
  }
}

extension ValidationExtensionsForNull<T> on T? {
  bool validateSelection(String fieldName) {
    if (this == null) {
      CustomToast.showError('${AppStrings.pleaseSelect} $fieldName');
      return false;
    }
    return true;
  }
}

extension ValidationTimeExtensions on int {
  bool validTime(String fieldName) {
    if (this == 0) {
      CustomToast.showError('${AppStrings.invalid} $fieldName');
      return false;
    }
    return true;
  }
}

extension ValidationExtensionsForMap on Map<String, String> {
  bool validateMapValue({required String key, required String fieldName}) {
    if ((this[key] ?? '').trim().isEmpty) {
      CustomToast.showError('$fieldName ${AppStrings.canNotBeEmpty}');
      return false;
    }
    return true;
  }
}
