import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<PermissionResult> checkPermission(
    PermissionType permissionType,
  ) async {
    final status = await permissionType._permission.status;
    if (status.isGranted) {
      return PermissionResult(PermissionState.granted, false);
    }
    var isFirstPermanentlyDenied = false;
    // ignore: lines_longer_than_80_chars
    // This is for Android, don't show the dialog in the first denial (OS asks twice)
    permissionType._permission.onDeniedCallback(() {
      isFirstPermanentlyDenied = true;
    });
    // If the permission is denied/permanently denied, the user has to open the app settings
    final result = await permissionType._permission.request();
    return PermissionResult(
      PermissionState._getByValue(result),
      isFirstPermanentlyDenied,
    );
  }

  Future<bool> openAppPermissionSettings() async {
    return openAppSettings();
  }
}

enum PermissionType {
  camera(Permission.camera),
  storageRead(Permission.storage);

  const PermissionType(this._permission);

  final Permission _permission;

  Future<bool> get isGranted => _permission.isGranted;

  String get dialogText =>
      index == 0
          ? 'Please grant permission for camera access from app settings.'
          : 'Please grant permission for gallery access from app settings.';
}

class PermissionResult {
  const PermissionResult(this.state, this.isFirstPermanentlyDenied);

  final PermissionState state;
  final bool isFirstPermanentlyDenied;
}

enum PermissionState {
  granted(PermissionStatus.granted),
  denied(PermissionStatus.denied),
  permanentlyDenied(PermissionStatus.permanentlyDenied);

  const PermissionState(this._value);

  final PermissionStatus _value;

  bool get isGranted => this == granted;

  bool get isDenied => this == denied;

  bool get isPermanentlyDenied =>
      this == permanentlyDenied || _value == PermissionStatus.restricted;

  static PermissionState _getByValue(PermissionStatus status) {
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return granted;
    }
    if (status == PermissionStatus.restricted ||
        status == PermissionStatus.permanentlyDenied) {
      return permanentlyDenied;
    }
    return denied;
  }
}
