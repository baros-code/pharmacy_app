import 'package:flutter/material.dart';

import '../../../core/utils/widget_ext.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    required this.items,
    this.toggleItems,
    required this.searchBarHintText,
    this.enableShadows = false,
    this.padding,
    this.itemPadding,
    this.onSearchTextChanged,
  });

  final List<SearchItem> items;
  final List<ToggleItem>? toggleItems;
  final String searchBarHintText;
  final bool enableShadows;
  final EdgeInsets? padding;
  final EdgeInsets? itemPadding;
  final Future<void> Function(String)? onSearchTextChanged;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late List<SearchItem> _items;
  String _currentSearchText = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  @override
  void didUpdateWidget(covariant SearchView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = widget.items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              widget.padding != null
                  ? EdgeInsets.fromLTRB(
                    widget.padding!.left,
                    widget.padding!.top,
                    widget.padding!.right,
                    0,
                  )
                  : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                hintText: widget.searchBarHintText,
                onChanged: _searchInItems,
                onSubmitted: _searchInItems,
              ),
              SizedBox(height: _currentSearchText.isEmpty ? 4 : 8),
              if (_currentSearchText.isNotEmpty)
                _ResultsText(
                  itemCount: _items.where((e) => e.isVisible).length,
                ),
              if (widget.toggleItems != null && widget.toggleItems!.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 16),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: _ToggleButtons(
                      items: widget.toggleItems!,
                      onItemSelected: (item) {
                        setState(() {
                          _items = item.itemsOnSelection;
                        });
                      },
                      onSelectionCleared: () {
                        setState(() {
                          _items = widget.items;
                          _searchInItems(_currentSearchText);
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        _isSearching
            ? Expanded(child: Center(child: CircularProgressIndicator()))
            : Flexible(
              child: _ListView(
                items: _items,
                padding:
                    widget.padding != null
                        ? EdgeInsets.fromLTRB(
                          widget.padding!.left,
                          widget.toggleItems == null ? 24 : 8,
                          widget.padding!.right,
                          widget.padding!.bottom,
                        )
                        : EdgeInsets.only(
                          top:
                              widget.toggleItems != null &&
                                      widget.toggleItems!.length > 1
                                  ? 8
                                  : 24,
                        ),
                itemPadding: widget.itemPadding,
              ),
            ),
      ],
    );
  }

  void _searchInItems(String text) async {
    _currentSearchText = text;
    // Remote search
    if (widget.onSearchTextChanged != null) {
      setState(() {
        _isSearching = true;
      });
      await widget.onSearchTextChanged?.call(text);
      setState(() {
        _isSearching = false;
      });
    }
    // Local search
    else {
      if (mounted) {
        setState(() {
          for (final item in _items) {
            item.isVisible = item.searchTexts.any(
              (e) => e.contains(RegExp(text, caseSensitive: false)),
            );
          }
        });
      }
    }
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.items, this.padding, this.itemPadding});

  final List<SearchItem> items;
  final EdgeInsets? padding;
  final EdgeInsets? itemPadding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: padding,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: itemPadding ?? EdgeInsets.zero,
          child: item.widget,
        );
      },
    );
  }
}

class _ResultsText extends StatelessWidget {
  const _ResultsText({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: itemCount.toString(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: ' results found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _ToggleButtons extends StatefulWidget {
  const _ToggleButtons({
    required this.items,
    required this.onItemSelected,
    required this.onSelectionCleared,
  });

  final List<ToggleItem> items;
  final void Function(ToggleItem) onItemSelected;
  final void Function() onSelectionCleared;

  @override
  State<_ToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<_ToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      renderBorder: false,
      isSelected: widget.items.map((e) => e.isSelected).toList(),
      selectedColor: Theme.of(context).primaryColor,
      fillColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      constraints: const BoxConstraints.tightForFinite(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      children:
          widget.items
              .asMap()
              .entries
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                    right: e.key < widget.items.length ? 4 : 0,
                  ),
                  child: _ToggleButton(
                    text: e.value.text,
                    isSelected: e.value.isSelected,
                  ),
                ),
              )
              .toList(),
      onPressed: (int index) {
        setState(() {
          for (final e in widget.items.asMap().entries) {
            if (e.key == index) {
              e.value.isSelected = !e.value.isSelected;
              e.value.isSelected
                  ? widget.onItemSelected(e.value)
                  : widget.onSelectionCleared();
            } else {
              e.value.isSelected = false;
            }
          }
        });
      },
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({required this.text, required this.isSelected});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 5),
      child: Text(
        text,
        style:
            isSelected
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColorLight,
                )
                : Theme.of(context).textTheme.bodyMedium,
      ),
    ).bordered(
      radius: BorderRadius.all(Radius.circular(16)),
      isEnabled: !isSelected,
      backgroundColor:
          isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColorLight,
      borderColor: isSelected ? null : Theme.of(context).disabledColor,
    );
  }
}

class SearchItem {
  SearchItem({
    required this.widget,
    required this.searchTexts,
    required this.isVisible,
  });

  final Widget widget;
  bool isVisible;
  final List<String> searchTexts;
}

class ToggleItem {
  ToggleItem({required this.text, required this.itemsOnSelection})
    : isSelected = false;

  final String text;
  final List<SearchItem> itemsOnSelection;
  bool isSelected;
}
