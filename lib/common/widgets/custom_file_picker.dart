import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../constants/image_path_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_geometry.dart';
import '../theme/app_size.dart';
import '../utils/file_picker_util.dart';
import 'custom_sized_box.dart';
import 'custom_text_widget.dart';
import 'images/custom_network_image.dart';
import 'images/custom_tappable_svg.dart';

class CustomFilePicker extends StatefulWidget {
  final String title;
  final FileType fileType;
  final String? initialUrl;
  final Function(PlatformFile? file, String? fileName) onSelected;

  const CustomFilePicker({
    super.key,
    required this.title,
    required this.onSelected,
    this.fileType = FileType.image,
    this.initialUrl,
  });

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  final _selectedFile = ValueNotifier<PlatformFile?>(null);
  final _initialUrl = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    if (widget.initialUrl != null) {
      _selectedFile.value = null;
      _initialUrl.value = widget.initialUrl;
    }
  }

  Future<void> _pickFile() async {
    final pickedFile = await FilePickerUtil.pickFile(
      fileType: widget.fileType,
      allowedExtensions: widget.fileType == FileType.image ? ['png'] : ['mp4'],
    );
    if (pickedFile != null) {
      _selectedFile.value = pickedFile.first;
      final fileName =
          widget.fileType == FileType.image
              ? '${DateTime.now().microsecondsSinceEpoch}_image.png'
              : '${DateTime.now().microsecondsSinceEpoch}_video.mp4';
      widget.onSelected(_selectedFile.value, fileName);
    }
  }

  void _delete() {
    _selectedFile.value = null;
    _initialUrl.value = null;
    widget.onSelected(null, null);
  }

  @override
  void dispose() {
    _selectedFile.dispose();
    _initialUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text16W400(widget.title, color: AppColors.accentColor),
              ValueListenableBuilder(
                valueListenable: _initialUrl,
                builder: (context, initialUrlValue, child) {
                  return ValueListenableBuilder(
                    valueListenable: _selectedFile,
                    builder: (context, selectedFileValue, child) {
                      return initialUrlValue == null &&
                              selectedFileValue == null
                          ? const SizedBox.shrink()
                          : CustomTappableSvg(
                            assetName: SvgImages.deleteIcon,
                            onTap: _delete,
                            height: AppSize.size24,
                            width: AppSize.size24,
                            color: AppColors.red,
                          );
                    },
                  );
                },
              ),
            ],
          ),
          const SBH10(),
        ],
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _pickFile,
            child: Container(
              height: AppSize.size220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.a15,
                border: Border.all(color: AppColors.accentColor),
              ),
              child: ValueListenableBuilder<PlatformFile?>(
                valueListenable: _selectedFile,
                builder: (context, selectedFile, child) {
                  return ValueListenableBuilder<String?>(
                    valueListenable: _initialUrl,
                    builder: (context, initialUrl, child) {
                      if (selectedFile != null) {
                        return widget.fileType == FileType.image
                            ? Padding(
                              padding: AppEdgeInsets.a10,
                              child: ClipRRect(
                                borderRadius: AppBorderRadius.a15,
                                child: Image.memory(
                                  selectedFile.bytes!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: AppSize.size220,
                                ),
                              ),
                            )
                            : const SizedBox();
                      } else if (initialUrl != null) {
                        return widget.fileType == FileType.image
                            ? CustomNetworkImage(
                              imageUrl: initialUrl,
                              fit: BoxFit.cover,
                              borderRadius: AppBorderRadius.a15,
                              width: double.infinity,
                              height: AppSize.size220,
                            )
                            : const SizedBox();
                      }
                      return const Center(
                        child: Icon(
                          Icons.add_box_outlined,
                          color: AppColors.accentColor,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
