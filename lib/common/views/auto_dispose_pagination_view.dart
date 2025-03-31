import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/error/views/bottom_error_view.dart';
import '../../modules/error/views/full_error_view.dart';
import '../constants/app_strings_constants.dart';
import '../states/pagination_state.dart';
import '../widgets/custom_circular_progress_indicator.dart';
import '../widgets/custom_text_widget.dart';

class AutoDisposePaginationView<T> extends ConsumerStatefulWidget {
  const AutoDisposePaginationView({
    super.key,
    required this.provider,
    required this.success,
    this.emptyMessage = AppStrings.dataNotFound,
    this.onFirstPageRefresh,
    this.onNextPageRefresh,
    this.separatorBuilder,
    this.onPageEndReached,
    this.listViewPadding,
    this.loadingWidget,
  });

  final AutoDisposeNotifierProvider provider;
  final Widget Function(T data) success;
  final Widget? separatorBuilder;
  final String emptyMessage;
  final VoidCallback? onFirstPageRefresh;
  final VoidCallback? onNextPageRefresh;
  final VoidCallback? onPageEndReached;
  final EdgeInsetsGeometry? listViewPadding;
  final Widget? loadingWidget;

  @override
  ConsumerState<AutoDisposePaginationView<T>> createState() =>
      _ConsumerPaginationViewState<T>();
}

class _ConsumerPaginationViewState<T>
    extends ConsumerState<AutoDisposePaginationView<T>> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        widget.onPageEndReached?.call();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    if (state is PaginationLoadingState) {
      return widget.loadingWidget ?? const CPI();
    } else if (state is PaginationErrorState) {
      return FullErrorView(
        exception: state.firstPageException!,
        onRefresh:
            widget.onFirstPageRefresh ?? () => ref.invalidate(widget.provider),
      );
    } else if (state is PaginationEmptyState) {
      return Center(child: Text16W500(widget.emptyMessage));
    } else if (state is PaginationSuccessState) {
      final data = state.data;
      return ListView.separated(
        controller: controller,
        itemCount: data!.length + 1,
        padding: widget.listViewPadding,
        itemBuilder: (context, index) {
          if (index < data.length) {
            return widget.success(data[index]);
          } else if (state.nextPageAvailable) {
            return const CPI();
          } else if (state.nextPageException != null) {
            return BottomErrorView(
              exception: state.nextPageException!,
              onRefresh: widget.onNextPageRefresh,
            );
          } else {
            return const SizedBox();
          }
        },
        separatorBuilder:
            (context, index) => widget.separatorBuilder ?? const Divider(),
      );
    } else {
      return const SizedBox();
    }
  }
}
