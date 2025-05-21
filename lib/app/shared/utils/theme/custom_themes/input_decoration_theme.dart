import 'package:flutter/material.dart';

class TInputDecorationTheme {
  TInputDecorationTheme._();

  static final lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
  );
  static final darkInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
  );
}
