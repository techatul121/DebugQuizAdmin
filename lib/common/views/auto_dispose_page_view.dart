import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/error/views/full_error_view.dart';
import '../constants/app_strings_constants.dart';
import '../states/page_state.dart';
import '../widgets/custom_circular_progress_indicator.dart';
import '../widgets/custom_text_widget.dart';

class AutoDisposePageView<T> extends ConsumerWidget {
  const AutoDisposePageView({
    super.key,
    required this.provider,
    required this.success,
    this.emptyMessage = AppStrings.dataNotFound,
    this.initialMessage = '',
    this.onRefresh,
    this.loadingWidget,
    this.errorWidget,
  });

  final AutoDisposeNotifierProvider provider;
  final Widget Function(T data) success;
  final String emptyMessage;
  final String initialMessage;
  final VoidCallback? onRefresh;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    if (state is PageInitialState) {
      return Center(child: Text16W500(initialMessage));
    } else if (state is PageLoadingState) {
      return loadingWidget ?? const CPI();
    } else if (state is PageErrorState) {
      return errorWidget ??
          FullErrorView(
            exception: state.exception!,
            onRefresh: onRefresh ?? () => ref.invalidate(provider),
          );
    } else if (state is PageEmptyState) {
      return Center(child: Text16W500(emptyMessage));
    } else if (state is PageLoadedState) {
      return success(state.model!);
    } else {
      return const SizedBox();
    }
  }
}
