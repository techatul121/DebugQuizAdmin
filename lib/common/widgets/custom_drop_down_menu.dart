import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/error/views/full_error_view.dart';
import '../../services/remote/db/db_exception.dart';
import '../extensions/list_extension.dart';
import '../states/page_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_geometry.dart';
import '../theme/app_size.dart';
import '../utils/debouncer.dart';
import 'buttons/custom_icon_button.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_text_form_field.dart';
import 'custom_text_widget.dart';
import 'keyboard_intents.dart';

class CustomDropDownMenuItem<T> {
  T value;
  String label;

  CustomDropDownMenuItem({required this.value, required this.label});
}

class CustomDropDownMenuController<T> extends ChangeNotifier {
  CustomDropDownMenuController();

  final List<CustomDropDownMenuItem<T>> _items = [];
  final List<GlobalKey> _itemKeys = [];

  List<CustomDropDownMenuItem<T>> get items => _items;

  List<GlobalKey> get itemKeys => _itemKeys;

  PageState state = PageInitialState();

  void loading() {
    state = PageLoadingState();
    notifyListeners();
  }

  void error(DBException e) {
    state = PageErrorState(e);
    notifyListeners();
  }

  void success(List<CustomDropDownMenuItem<T>> items) {
    _items.clear();
    _items.addAll(items);
    _generateItemsKeys();
    state = PageLoadedState(_items);
    notifyListeners();
  }

  void _generateItemsKeys() {
    _itemKeys.clear();
    _itemKeys.addAll(List.generate(_items.length, (index) => GlobalKey()));
  }
}

class CustomDropDownMenu<T> extends ConsumerStatefulWidget {
  const CustomDropDownMenu({
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
  });

  final String? hintText;
  final T? initialValue;
  final bool customInitialValue;
  final List<CustomDropDownMenuItem<T>> initialItems;
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
  final CustomDropDownMenuController? controller;
  final VoidCallback? onRefresh;
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? iconColor;

  @override
  ConsumerState<CustomDropDownMenu<T>> createState() =>
      _CustomSearchableDropDownState<T>();
}

class _CustomSearchableDropDownState<T>
    extends ConsumerState<CustomDropDownMenu<T>> {
  final _globalKey = GlobalKey();
  late final CustomDropDownMenuController controller;
  final _textEditingController = TextEditingController();
  final _portalController = OverlayPortalController();
  final _link = LayerLink();
  int _highlightIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.initialItems.isEmpty) {
      controller = widget.controller!;
    } else {
      controller = CustomDropDownMenuController<T>();
      controller.success(widget.initialItems);
      initialSelection();
    }
    controller.addListener(resetHighlightIndex);
  }

  @override
  void didUpdateWidget(covariant CustomDropDownMenu<T> oldWidget) {
    initialSelection();
    super.didUpdateWidget(oldWidget);
  }

  void initialSelection() {
    final index = controller.items.indexWhere(
      (entry) => entry.value == widget.initialValue,
    );
    if (index != -1) {
      _highlightIndex = index;
      final data = controller.items[index];
      _textEditingController.text = data.label;
    } else {
      if (widget.customInitialValue) {
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

  _search(String value) {
    final index = controller.items.indexWhere(
      (element) => element.label.toLowerCase().startsWith(value.toLowerCase()),
    );
    if (value.isEmpty) {
      setState(() {
        _highlightIndex = -1;
      });
    } else if (index != -1) {
      setState(() {
        _highlightIndex = index;
      });
      _scrollToItem();
    } else {
      setState(() {
        _highlightIndex = -1;
      });
    }
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!_portalController.isShowing) {
        _portalController.show();
        _scrollToItem();
      }
    });
  }

  /// Move Down the list
  void _moveDown() {
    if (_portalController.isShowing &&
        _highlightIndex < controller.items.length - 1) {
      setState(() {
        _highlightIndex++;
      });
      _textEditingController.text = controller.items[_highlightIndex].label;
      _scrollToItem();
    }
  }

  /// Move up the list
  void _moveUp() {
    if (_portalController.isShowing && _highlightIndex > 0) {
      setState(() {
        _highlightIndex--;
      });
      _textEditingController.text = controller.items[_highlightIndex].label;
      _scrollToItem();
    }
  }

  /// Scroll to highlight item
  void _scrollToItem() {
    if (_highlightIndex == -1) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final highlightContext =
          controller.itemKeys[_highlightIndex].currentContext;
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

  void _onTap(index) {
    _highlightIndex = index;
    _selectItem();
  }

  /// Invoke when enter key pressed
  void _selectItem() {
    if (_highlightIndex != -1) {
      _textEditingController.text = controller.items[_highlightIndex].label;
      widget.onSelect?.call(controller.items[_highlightIndex].value);
      _portalController.hide();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _escape() {
    _portalController.hide();
  }

  @override
  void dispose() {
    controller.removeListener(resetHighlightIndex);
    controller.dispose();
    _textEditingController.dispose();
    _highlightIndex = -1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onInvoke: (ArrowDownIntent intent) => _moveDown(),
          ),
          ArrowUpIntent: CallbackAction<ArrowUpIntent>(
            onInvoke: (ArrowUpIntent intent) => _moveUp(),
          ),
          EnterIntent: CallbackAction<EnterIntent>(
            onInvoke: (EnterIntent intent) => _selectItem(),
          ),
          EscIntent: CallbackAction<EscIntent>(
            onInvoke: (EscIntent intent) => _escape(),
          ),
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
                          listenable: controller,
                          builder: (context, child) {
                            if (controller.state is PageInitialState) {
                              return const Center(
                                child: Text16W400('Type something to search'),
                              );
                            } else if (controller.state is PageLoadingState) {
                              return const CPI();
                            } else if (controller.state is PageErrorState) {
                              return FullErrorView(
                                exception: controller.state.exception!,
                                onRefresh: widget.onRefresh,
                              );
                            }
                            return SingleChildScrollView(
                              child: ClipRRect(
                                borderRadius: AppBorderRadius.a10,
                                child: Column(
                                  children: controller.items
                                      .mapIndexed((index, element) {
                                        return InkWell(
                                          borderRadius: AppBorderRadius.a5,
                                          key: controller.itemKeys[index],
                                          onTap: () => _onTap(index),
                                          child: Container(
                                            color:
                                                widget.fillColor ??
                                                (index == _highlightIndex
                                                    ? AppColors.blue.withValues(
                                                      alpha: 0.3,
                                                    )
                                                    : null),
                                            padding: AppEdgeInsets.a10,
                                            width: double.infinity,
                                            child:
                                                widget.childBuilder == null
                                                    ? Text16W500(
                                                      element.label,
                                                      color: widget.textColor,
                                                    )
                                                    : widget.childBuilder!(
                                                      element.value,
                                                    ),
                                          ),
                                        );
                                      })
                                      .toList(growable: false),
                                ),
                              ),
                            );
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
                borderColor: widget.borderColor,
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
                        : null,
                controller: _textEditingController,
                onTap: () {
                  _showOverlay();
                },
                onChanged: (value) {
                  _showOverlay();
                  if (widget.initialItems.isEmpty) {
                    Debouncer.debounce(() {
                      widget.onChanged?.call(value);
                    });
                  } else {
                    _search(value);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
