import 'dart:developer';

import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<List<PlatformFile>?> pickFile({
    required FileType fileType,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : fileType,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );

      return result?.files;
    } catch (e) {
      log('Error picking file: $e');
      return null;
    }
  }
}
