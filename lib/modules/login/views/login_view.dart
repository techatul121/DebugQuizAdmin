import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/validation_extensions.dart';

import '../../../common/states/page_state.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/utils/custom_toast.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/custom_responsive_builder.dart';

import '../../../routes/utils/redirect_utils.dart';
import '../../coming_soon/coming_soon_view.dart';
import '../model/login_request_model.dart';
import '../model/session_model.dart';
import '../provider/auth_provider.dart';
import '../provider/login_in_provider.dart';
import '../widgets/login_form.dart';

class LoginView extends ConsumerStatefulWidget {
  LoginView({super.key});

  static const String path = '/login';
  static const String name = 'login';

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    ref.listen<PageState<SessionModel>>(loginProvider, (_, state) {
      if (state is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (state is PageErrorState) {
        CustomToast.showError(state.exception!.message);
        CustomDialog.closeDialog();
      } else if (state is PageLoadedState) {
        CustomToast.showSuccess('Login successfully');
        CustomDialog.closeDialog();
        ref.read(authProvider.notifier).authenticate(session: state.model!);
        ref.read(redirectScreenUtil.notifier).dashboardView();
        log('Response ${state.model?.toJson()}');
      }
    });
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: CustomResponsiveBuilder(
        mobile: const ComingSoonView(),
        desktop: LoginForm(
          onEmailChanged: (value) {
            email = value;
          },
          onPasswordChanged: (value) {
            password = value;
          },
          onSubmit: () {
            if (email.isEmail() && password.isValid(AppStrings.password)) {
              ref
                  .read(loginProvider.notifier)
                  .login(LoginRequestModel(email: email, password: password));
            }
          },
        ),
        tablet: const ComingSoonView(),
      ),
    );
  }
}
