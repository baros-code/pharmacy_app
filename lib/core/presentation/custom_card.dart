import 'package:flutter/material.dart';
import '../utils/widget_ext.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.constraints,
    this.enableShadows = true,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.shadowColor,
    this.showBorder = false,
    this.showArrowIcon = false,
    this.shape,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final bool enableShadows;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? shadowColor;
  final bool showBorder;
  final bool showArrowIcon;
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        constraints: constraints,
        padding: padding,
        decoration: _buildDecoration(context),
        child:
            showArrowIcon
                ? Row(
                  children: [
                    Expanded(child: child),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )
                : child,
      ).bordered(
        isEnabled: showBorder,
        borderColor: borderColor ?? Theme.of(context).shadowColor,
        radius: borderRadius ?? BorderRadius.circular(16),
      ),
    );
  }

  // Helpers
  Decoration _buildDecoration(BuildContext context) {
    return shape != null
        ? ShapeDecoration(
          shape: shape!,
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          shadows: _buildShadows(context),
        )
        : BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          boxShadow: _buildShadows(context),
        );
  }

  List<BoxShadow>? _buildShadows(BuildContext context) {
    return enableShadows
        ? [
          BoxShadow(
            color:
                shadowColor ??
                Theme.of(context).shadowColor.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color:
                shadowColor ??
                Theme.of(context).shadowColor.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ]
        : null;
  }

  // - Helpers
}
