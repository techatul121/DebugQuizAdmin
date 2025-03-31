import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_strings_constants.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_size.dart';
import 'custom_sized_box.dart';
import 'custom_text_widget.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final bool enabled;
  final bool autofocus;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final int? maxLength;
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final double? heightTextFormField;

  CustomTextFormField({
    super.key,
    this.title = '',
    this.controller,
    this.maxLines,
    this.onChanged,
    this.initialValue,
    this.onFieldSubmitted,
    this.inputType,
    this.inputFormatters,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.onTap,
    this.borderColor,
    this.textColor,
    this.fillColor,
    this.maxLength,
    this.heightTextFormField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text16W500(title, color: AppColors.accentColor),
          const SBH10(),
        ],
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: !enabled,
            child: TextFormField(
              autofocus: autofocus,
              cursorColor: AppColors.black,
              maxLines: maxLines,
              controller: controller,
              readOnly: readOnly,
              inputFormatters: inputFormatters,
              onFieldSubmitted: onFieldSubmitted,
              initialValue: initialValue,
              keyboardType: inputType,
              onChanged: onChanged,
              enabled: enabled,
              maxLength: maxLength,
              decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxHeight: heightTextFormField ?? AppSize.size50,
                  minHeight: heightTextFormField ?? AppSize.size50,
                ),
                fillColor: fillColor,
                counterText: '',
                hintText: hintText ?? AppStrings.typeHere,
                hintStyle:
                    context.isDesktop
                        ? null
                        : context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.grey,
                        ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
              style: context.textTheme.bodyLarge!.copyWith(
                color: textColor ?? AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
