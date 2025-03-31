import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/context_extensions.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';

import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_form_field.dart';
import '../../../common/widgets/custom_text_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.onEmailChanged,
    required this.onSubmit,
    required this.onPasswordChanged,
  });

  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CustomCard(
            width: AppSize.size500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SBH40(),

                const Align(
                  alignment: Alignment.center,
                  child: Text28W400(AppStrings.adminLogin),
                ),
                const SBH30(),
                CustomTextFormField(
                  title: AppStrings.email,
                  onChanged: onEmailChanged,
                  inputType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    onSubmit.call();
                  },
                ),
                const SBH10(),
                CustomTextFormField(
                  title: AppStrings.password,
                  onChanged: onPasswordChanged,
                  inputType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    onSubmit.call();
                  },
                ),
                const SBH30(),
                CustomFilledButton(
                  text: AppStrings.login,
                  onTap: onSubmit,
                  width: context.deviceWidth,
                ),
              ],
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: AppEdgeInsets.a10,
            child: Text16W500(
              '${AppStrings.version} ${AppStrings.versionNo}',
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
