import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/base_page.dart';
import 'selection_view.dart';

class SelectionPopup<T extends Object> extends StatefulWidget {
  const SelectionPopup({
    super.key,
    required this.items,
    required this.title,
    this.filterButtonText,
    required this.searchBarHintText,
    required this.selectionText,
    this.onSelectionResult,
  });

  final List<FilterItem<T>> items;
  final String title;
  final String? filterButtonText;
  final String searchBarHintText;
  final String selectionText;
  final void Function(List<T> result)? onSelectionResult;

  @override
  State<SelectionPopup> createState() => _SelectionPopupState<T>();
}

class _SelectionPopupState<T extends Object> extends State<SelectionPopup<T>> {
  final _filterResult = <FilterItem>[];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BasePage(
      backButtonEnabled: true,
      title: _Title(widget.title),
      body: Padding(
        padding:
            kIsWeb
                ? EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: 16,
                )
                : EdgeInsets.zero,
        child: SelectionView<T>(
          items: widget.items,
          searchBarHintText: widget.searchBarHintText,
          selectionText: widget.selectionText,
          onFilterResult: (items) {
            setState(() {
              _filterResult.clear();
              _filterResult.addAll(items);
            });
          },
        ),
      ),
      bottom: _Bottom(
        onFilterPressed:
            _filterResult.any((e) => e.isSelected)
                ? () {
                  Navigator.of(context).pop();
                  widget.onSelectionResult?.call(
                    _filterResult
                        .where((e) => e.isSelected)
                        .map((e) => e.filterObject as T)
                        .toList(),
                  );
                }
                : null,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall,
      maxLines: 1,
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({this.onFilterPressed});

  final void Function()? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          kIsWeb
              ? EdgeInsets.symmetric(horizontal: screenWidth * 0.2)
              : EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(double.infinity, 48)),
        onPressed: onFilterPressed,
        child: const Text('Apply'),
      ),
    );
  }
}
