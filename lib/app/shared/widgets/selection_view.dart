import 'package:flutter/material.dart';

import '../../../core/presentation/custom_card.dart';

class SelectionView<T extends Object> extends StatefulWidget {
  const SelectionView({
    super.key,
    required this.items,
    this.searchBarHintText,
    this.selectionText,
    this.selectButtonText,
    this.deselectButtonText,
    this.extraVerticalSpacing = 16,
    this.showItemsInContainer = true,
    this.searchEnabled = true,
    this.enableKeyboardFirst = false,
    this.onFilterResult,
  });

  final List<FilterItem<T>> items;
  final String? searchBarHintText;
  final String? selectionText;
  final String? selectButtonText;
  final String? deselectButtonText;
  final double extraVerticalSpacing;
  final bool showItemsInContainer;
  final bool searchEnabled;
  final bool enableKeyboardFirst;
  final void Function(List<FilterItem<T>>)? onFilterResult;

  @override
  State<SelectionView> createState() => _SelectionViewState<T>();
}

class _SelectionViewState<T extends Object> extends State<SelectionView<T>> {
  late List<FilterItem<T>> items;
  bool canSelectAll = false;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    canSelectAll = items.any((e) => !e.isSelected);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.searchEnabled)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchBar(
              textStyle: WidgetStateProperty.all(
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).primaryColorLight,
              ),
              hintStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
              ),
              hintText: widget.searchBarHintText,
              onChanged: _searchInAllItems,
            ),
          ),
        if (widget.selectionText != null)
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              widget.extraVerticalSpacing,
            ),
            child: _SelectionBody(
              selectedItemCount: items.where((e) => e.isSelected).length,
              selectionText: widget.selectionText!,
              selectionButtonText: canSelectAll ? 'Select all' : 'Deselect all',
              onSelectionButtonTap: () {
                setState(() {
                  for (final item in items) {
                    item.isSelected = canSelectAll;
                  }
                  canSelectAll = !canSelectAll;
                });
                widget.onFilterResult?.call(items);
              },
            ),
          ),
        const SizedBox(height: 4),
        Flexible(
          child: _ListView<T>(
            items: items,
            showItemsInContainer: widget.showItemsInContainer,
            onItemTap: (index) {
              setState(() {
                items[index].isSelected = !items[index].isSelected;
              });
              widget.onFilterResult?.call(items);
            },
          ),
        ),
      ],
    );
  }

  // Helpers
  void _searchInAllItems(String text) {
    if (mounted) {
      setState(() {
        for (final item in items) {
          item.isVisible = _searchInItem(item, text);
        }
      });
    }
  }

  bool _searchInItem(FilterItem<T> item, String text) {
    return item.searchTexts.any(
      (e) => e.contains(RegExp(text, caseSensitive: false)),
    );
  }

  // - Helpers
}

class _SelectionBody extends StatelessWidget {
  const _SelectionBody({
    required this.selectedItemCount,
    required this.selectionText,
    required this.selectionButtonText,
    this.onSelectionButtonTap,
  });

  final int selectedItemCount;
  final String selectionText;
  final String selectionButtonText;
  final void Function()? onSelectionButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: selectedItemCount.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: '  $selectionText',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const Spacer(),
        _SelectDeselectButton(
          text: selectionButtonText,
          onTap: onSelectionButtonTap,
        ),
      ],
    );
  }
}

class _ListView<T extends Object> extends StatelessWidget {
  const _ListView({
    required this.items,
    required this.showItemsInContainer,
    this.onItemTap,
  });

  final List<FilterItem<T>> items;
  final bool showItemsInContainer;
  final void Function(int)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, showItemsInContainer ? 16 : 12, 16, 10),
      child: Column(
        children:
            items
                .asMap()
                .entries
                .map(
                  (e) => Visibility(
                    visible: e.value.isVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: CustomCard(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        padding:
                            showItemsInContainer
                                ? const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                )
                                : EdgeInsets.zero,
                        onTap: () => onItemTap?.call(e.key),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              e.value.isSelected
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                              color:
                                  e.value.isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: e.value.widget),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _SelectDeselectButton extends StatelessWidget {
  const _SelectDeselectButton({required this.text, this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FilterItem<T extends Object> {
  FilterItem({
    this.filterObject,
    required this.widget,
    required this.searchTexts,
    this.isSelected = false,
    this.onSelected,
  }) : isVisible = true;

  final T? filterObject;
  final Widget widget;
  final List<String> searchTexts;
  bool isSelected;
  final void Function()? onSelected;
  bool isVisible;
}
