import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/error/views/full_error_view.dart';
import '../../services/remote/db/db_exception.dart';
import '../constants/app_strings_constants.dart';
import '../states/pagination_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_geometry.dart';
import '../theme/app_size.dart';
import '../utils/debouncer.dart';
import 'buttons/custom_icon_button.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_text_form_field.dart';
import 'custom_text_widget.dart';
import 'keyboard_intents.dart';

class CustomDropDownMenuPaginationItem<T> {
  T value;
  String label;

  CustomDropDownMenuPaginationItem({required this.value, required this.label});
}

class CustomDropDownMenuPaginationController<T> extends ChangeNotifier {
  final List<CustomDropDownMenuPaginationItem<T>> _items = [];
  final List<GlobalKey> _itemKeys = [];
  bool hasMoreItem = false;

  List<CustomDropDownMenuPaginationItem<T>> get items => _items;

  List<GlobalKey> get itemKeys => _itemKeys;
  DBException? nextPageException;
  PaginationState state = PaginationInitialState();

  void updateHasMore(bool value) {
    log('Data hasMoreItem $value');
    hasMoreItem = value;
    notifyListeners();
  }

  void updateNextPageException(DBException? exception) {
    nextPageException = exception;
    notifyListeners();
  }

  void loading() {
    state = PaginationLoadingState();
    notifyListeners();
  }

  void error(DBException e) {
    state = PaginationErrorState(e);
    notifyListeners();
  }

  void success(List<CustomDropDownMenuPaginationItem<T>> items) {
    _items.clear();
    _items.addAll(items);
    _generateItemsKeys();
    state = PaginationSuccessState(data: _items);
    notifyListeners();
  }

  void _generateItemsKeys() {
    _itemKeys.clear();
    _itemKeys.addAll(List.generate(_items.length, (index) => GlobalKey()));
  }
}

class CustomDropDownMenuWithPagination<T> extends ConsumerStatefulWidget {
  const CustomDropDownMenuWithPagination({
    super.key,
    this.hintText,
    this.initialValue,
    this.initialItems = const [],
    this.columnHeight,
    this.width,
    this.enabled = true,
    this.prefixIcon,
    this.onChanged,
    this.onSelect,
    this.childBuilder,
    this.controller,
    this.clear = false,
    this.title = '',
    this.onRefresh,
    this.borderColor,
    this.textColor,
    this.fillColor,
    this.iconColor,
    this.borderRadius = AppBorderRadius.a15,
    this.customInitialValue = false,
    this.readOnly = false,
    this.autoFocus = true,
    this.pageSize = 10,
    required this.onPaginate,
    this.onSearch,
    required this.scrollController,
  });

  final String? hintText;
  final T? initialValue;
  final bool customInitialValue;
  final List<CustomDropDownMenuPaginationItem<T>> initialItems;
  final double? columnHeight;
  final double? width;
  final String title;
  final bool enabled;
  final bool clear;
  final BorderRadius borderRadius;
  final bool readOnly;
  final bool autoFocus;
  final Widget? prefixIcon;

  final ValueChanged<String>? onChanged;
  final ValueChanged<T>? onSelect;
  final Widget Function(T data)? childBuilder;
  final CustomDropDownMenuPaginationController? controller;
  final VoidCallback? onRefresh;
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? iconColor;
  final ScrollController scrollController;
  final int pageSize;

  final Function(String query, int page, int pageSize)? onPaginate;

  final Function(String query)? onSearch;

  @override
  ConsumerState<CustomDropDownMenuWithPagination<T>> createState() =>
      _CustomSearchableDropDownState<T>();
}

class _CustomSearchableDropDownState<T>
    extends ConsumerState<CustomDropDownMenuWithPagination<T>>
    with AutomaticKeepAliveClientMixin {
  final _globalKey = GlobalKey();

  final _textEditingController = TextEditingController();
  final _portalController = OverlayPortalController();
  final _link = LayerLink();
  int _highlightIndex = -1;

  // Pagination state variables.
  final int _currentPage = 1;

  String _currentQuery = '';

  @override
  void initState() {
    super.initState();

    widget.controller!.addListener(resetHighlightIndex);
    widget.scrollController.addListener(() {
      final currentPixels = widget.scrollController.position.pixels;
      final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
      log(
        'Current Pixels: $currentPixels, Max Scroll Extent: $maxScrollExtent',
      );

      if (widget.controller!.hasMoreItem && currentPixels == maxScrollExtent) {
        log('Reached near bottom of the list, loading more items...');
        _loadMoreItems();
      }
    });
  }

  @override
  void didUpdateWidget(
    covariant CustomDropDownMenuWithPagination<T> oldWidget,
  ) {
    initialSelection();
    super.didUpdateWidget(oldWidget);
  }

  void initialSelection() {
    final index = widget.controller!.items.indexWhere(
      (entry) => entry.value == widget.initialValue,
    );
    log('Selected index $index');
    if (index != -1) {
      _highlightIndex = index;
      _textEditingController.text = widget.controller!.items[index].label;
    } else {
      if (widget.customInitialValue && widget.initialValue != null) {
        _textEditingController.text = widget.initialValue.toString();
      } else {
        _highlightIndex = -1;
        _textEditingController.text = '';
      }
    }
  }

  Size get _textFieldSize {
    final renderBox =
        _globalKey.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size;
  }

  void resetHighlightIndex() {
    _highlightIndex = -1;
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_portalController.isShowing) {
        _portalController.show();
        //    widget.onRefresh!();
      }
    });
  }

  void _moveDown() {
    if (_portalController.isShowing &&
        _highlightIndex < widget.controller!.items.length - 1) {
      setState(() => _highlightIndex++);
      _textEditingController.text =
          widget.controller!.items[_highlightIndex].label;
      _scrollToItem();
    }
  }

  void _moveUp() {
    if (_portalController.isShowing && _highlightIndex > 0) {
      setState(() => _highlightIndex--);
      _textEditingController.text =
          widget.controller!.items[_highlightIndex].label;
      _scrollToItem();
    }
  }

  void _scrollToItem() {
    if (_highlightIndex == -1) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final highlightContext =
          widget.controller!.itemKeys[_highlightIndex].currentContext;
      if (highlightContext != null) {
        Scrollable.ensureVisible(
          highlightContext,
          alignment: 0.1,
          alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
          duration: const Duration(milliseconds: 200),
        );
      }
    });
  }

  void _onTap(int index) {
    _highlightIndex = index;
    _selectItem();
  }

  void _selectItem() {
    if (_highlightIndex != -1) {
      _textEditingController.text =
          widget.controller!.items[_highlightIndex].label;
      widget.onSelect?.call(widget.controller!.items[_highlightIndex].value);
      _portalController.hide();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _escape() => _portalController.hide();

  /// Loads more items when scrolling nears the end (pagination mode).
  Future<void> _loadMoreItems() async {
    final nextPage = _currentPage;
    await widget.onPaginate!(_currentQuery, nextPage, widget.pageSize);
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      controller: widget.scrollController,
      itemCount: widget.controller!.items.length + 1,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < widget.controller!.items.length) {
          final element = widget.controller!.items[index];
          return InkWell(
            borderRadius: AppBorderRadius.a5,
            key: widget.controller!.itemKeys[index],
            onTap: () => _onTap(index),
            child: Container(
              color:
                  widget.fillColor ??
                  (index == _highlightIndex
                      ? AppColors.blue.withValues(alpha: 0.3)
                      : null),
              padding: AppEdgeInsets.a10,
              width: double.infinity,
              child:
                  widget.childBuilder == null
                      ? Text16W500(element.label, color: widget.textColor)
                      : widget.childBuilder!(element.value),
            ),
          );
        } else if (widget.controller!.hasMoreItem) {
          return const Center(child: CircularProgressIndicator());
        } else if (widget.controller!.nextPageException != null) {
          return FullErrorView(
            exception: widget.controller!.nextPageException!,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Shortcuts(
      shortcuts: const <SingleActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.arrowDown): ArrowDownIntent(),
        SingleActivator(LogicalKeyboardKey.arrowUp): ArrowUpIntent(),
        SingleActivator(LogicalKeyboardKey.enter): EnterIntent(),
        SingleActivator(LogicalKeyboardKey.escape): EscIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ArrowDownIntent: CallbackAction<ArrowDownIntent>(
            onInvoke: (intent) => _moveDown(),
          ),
          ArrowUpIntent: CallbackAction<ArrowUpIntent>(
            onInvoke: (intent) => _moveUp(),
          ),
          EnterIntent: CallbackAction<EnterIntent>(
            onInvoke: (intent) => _selectItem(),
          ),
          EscIntent: CallbackAction<EscIntent>(onInvoke: (intent) => _escape()),
        },
        child: CompositedTransformTarget(
          link: _link,
          child: OverlayPortal(
            controller: _portalController,
            overlayChildBuilder: (context) {
              return CompositedTransformFollower(
                link: _link,
                targetAnchor: Alignment.bottomLeft,
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: TapRegion(
                    groupId: 1,
                    onTapOutside: (event) => _portalController.hide(),
                    child: SizedBox(
                      height: widget.columnHeight,
                      width: _textFieldSize.width,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppBorderRadius.a10,
                        ),
                        child: ListenableBuilder(
                          listenable: widget.controller!,
                          builder: (context, child) {
                            if (widget.controller!.state
                                is PaginationInitialState) {
                              return const Center(
                                child: Text14W400(AppStrings.dataNotFound),
                              );
                            } else if (widget.controller!.state
                                is PaginationLoadingState) {
                              return const CPI();
                            } else if (widget.controller!.state
                                is PaginationErrorState) {
                              return FullErrorView(
                                exception:
                                    widget
                                        .controller!
                                        .state
                                        .firstPageException!,
                                onRefresh: widget.onRefresh,
                              );
                            }
                            return _buildList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: SizedBox(
              width: widget.width ?? AppSize.size170,
              child: CustomTextFormField(
                key: _globalKey,
                enabled: widget.enabled,
                title: widget.title,
                autofocus: widget.autoFocus,
                readOnly: widget.readOnly,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                textColor: widget.textColor,
                fillColor: widget.fillColor,
                borderColor: widget.borderColor ?? AppColors.accentColor,
                borderRadius: widget.borderRadius,
                suffixIcon:
                    widget.enabled
                        ? widget.clear
                            ? ValueListenableBuilder(
                              valueListenable: _textEditingController,
                              builder: (context, value, child) {
                                return CustomIconButton(
                                  iconData: Icons.clear,
                                  color:
                                      value.text.isEmpty ? Colors.grey : null,
                                  onTap:
                                      value.text.isNotEmpty
                                          ? () {
                                            _textEditingController.clear();
                                            _highlightIndex = -1;
                                            widget.onChanged?.call('');
                                          }
                                          : null,
                                );
                              },
                            )
                            : CustomIconButton(
                              iconData: Icons.keyboard_arrow_down_sharp,
                              color: widget.iconColor,
                              onTap: () {
                                _showOverlay();
                              },
                            )
                        : const CustomIconButton(
                          iconData: Icons.keyboard_arrow_down_sharp,
                          color: AppColors.grey,
                        ),
                controller: _textEditingController,
                onTap: widget.enabled ? _showOverlay : null,
                onChanged: (value) {
                  _currentQuery = value;
                  _showOverlay();
                  if (widget.onSearch != null) {
                    Debouncer.debounce(() async {
                      await widget.onSearch!(_textEditingController.text);
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
