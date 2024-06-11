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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? context.colors.mainGreen,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: labelStyle ?? context.styles.s18w500,
        ),
      ),
    );
  }
}
