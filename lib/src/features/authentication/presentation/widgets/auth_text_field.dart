import 'package:finance_manager/src/core/utils/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    this.autoCorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    super.key,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoCorrect;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableSuggestions: widget.enableSuggestions,
      obscureText: widget.obscureText,
      autocorrect: widget.autoCorrect,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      cursorColor: context.colors.gray,
    );
  }
}
