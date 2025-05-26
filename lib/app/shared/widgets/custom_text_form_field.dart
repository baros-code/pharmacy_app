import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    required this.onChanged,
  });

  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).disabledColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).highlightColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).highlightColor),
        ),
      ),
      obscureText: widget.obscureText,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.onChanged,
    );
  }
}
