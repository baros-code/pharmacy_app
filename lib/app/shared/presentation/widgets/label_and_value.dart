import 'package:flutter/material.dart';

class LabelAndValue extends StatelessWidget {
  const LabelAndValue(this.label, this.value, {super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(value, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
