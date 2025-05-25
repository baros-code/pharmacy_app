import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../presentation/toast_card.dart';

abstract class PopupManager {
  Future<void> showPopup(
    BuildContext context,
    Widget content, {
    Alignment alignment,
    EdgeInsets padding,
    Color? barrierColor,
    bool preventClose,
    bool preventBackPress,
  });

  void showProgress(BuildContext context);

  void hideProgress(BuildContext context);

  void showToastMessage(
    BuildContext context,
    String text, {
    Duration duration = const Duration(milliseconds: 3200),
  });

  Future<void> showFullScreenPopup(BuildContext context, Widget content);

  Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? initialDate,
    String? helpText,
  });
}

class PopupManagerImpl implements PopupManager {
  bool _isProgressShowing = false;

  @override
  Future<void> showPopup(
    BuildContext context,
    Widget content, {
    Alignment alignment = Alignment.center,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
    Color? barrierColor,
    bool preventClose = false,
    bool preventBackPress = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: !preventClose,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black26,
      transitionBuilder: (_, anim1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },

      pageBuilder: (_, __, ___) {
        return SafeArea(
          left: true,
          top: true,
          right: true,
          bottom: true,
          child: PopScope(
            canPop: !preventBackPress,
            child: Align(
              alignment: alignment,
              child: Padding(padding: EdgeInsets.zero, child: content),
            ),
          ),
        );
      },
    );
  }

  @override
  void showProgress(BuildContext context) {
    if (!_isProgressShowing) {
      _isProgressShowing = true;
      showPopup(
        context,
        const CircularProgressIndicator(),
        padding: EdgeInsets.zero,
        preventClose: true,
        preventBackPress: true,
      );
    }
  }

  @override
  void hideProgress(BuildContext context) {
    if (_isProgressShowing) {
      Navigator.of(context).pop();
      _isProgressShowing = false;
    }
  }

  @override
  void showToastMessage(
    BuildContext context,
    String text, {
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    // Check if context is still valid
    if (!context.mounted) return;

    final fToast = FToast();
    fToast.init(context);
    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      toastDuration: duration,
      gravity: ToastGravity.CENTER,
      child: ToastCard(text),
    );
  }

  @override
  Future<void> showFullScreenPopup(BuildContext context, Widget content) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black26,
      transitionBuilder: (_, anim1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (_, __, ___) {
        return SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: false,
          child: Align(
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.zero, child: content),
          ),
        );
      },
    );
  }

  @override
  Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? initialDate,
    String? helpText,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: helpText,
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Theme.of(context).primaryColor,
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            child: child!,
          ),
    );
  }
}
