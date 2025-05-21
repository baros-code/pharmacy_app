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

  // void showScrollPicker(BuildContext context);
}

class PopupManagerImpl implements PopupManager {
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
    // _showGeneralDialog(
    //   context,
    //   content,
    //   alignment: alignment,
    //   padding: padding,
    //   preventClose: preventClose,
    //   preventBackPress: preventBackPress,
    //   barrierColor: barrierColor,
    //   showFullScreen: false,
    // );
  }

  @override
  void showProgress(BuildContext context) {
    showPopup(
      context,
      const CircularProgressIndicator(),
      padding: EdgeInsets.zero,
      preventClose: true,
      preventBackPress: true,
    );
  }

  @override
  void hideProgress(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void showToastMessage(
    BuildContext context,
    String text, {
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    FToast()
      ..init(context)
      ..removeQueuedCustomToasts()
      ..showToast(
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
}
