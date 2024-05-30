import 'package:finance_manager/src/core/utils/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.color,
    super.key,
    this.onPressed,
    this.labelStyle,
  });

  final String label;
  final TextStyle? labelStyle;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: labelStyle ?? context.colors.,
      ),
    );
  }
}
