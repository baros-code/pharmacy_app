import 'package:flutter/material.dart';

import '../../utils/asset_config.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.text,
    this.imagePath,
    this.textStyle,
    this.imageScale = 4,
    this.showImage = true,
    this.textDistanceFromImage = 16,
    this.padding = const EdgeInsets.all(16),
    this.onTryAgain,
  });

  final String text;
  final TextStyle? textStyle;
  final String? imagePath;
  final double imageScale;
  final bool showImage;
  final double? textDistanceFromImage;
  final EdgeInsets? padding;
  final VoidCallback? onTryAgain;

  const EmptyView.tryAgain({
    super.key,
    required this.text,
    String? imagePath,
    this.textStyle,
    this.imageScale = 4,
    this.showImage = true,
    this.textDistanceFromImage,
    this.padding,
    required this.onTryAgain,
  }) : imagePath = imagePath ?? AssetConfig.emptyView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showImage) ...[
            Image.asset(
              imagePath ?? AssetConfig.emptyView,
              scale: imageScale,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: textDistanceFromImage ?? 16),
          ],
          Flexible(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          if (onTryAgain != null) ...[
            const SizedBox(height: 16),
            _ReloadButton(onTryAgain!),
          ],
        ],
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton(this.onTryAgain);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTryAgain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetConfig.reloadIcon,
            width: 20,
            height: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Reload',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
