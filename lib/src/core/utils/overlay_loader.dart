import 'package:finance_manager/src/core/utils/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class OverlayLoader {
  OverlayLoader._();

  static OverlayEntry? _overlayEntry;

  static void _createOverlayEntry(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => const Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: LoadingIndicator(),
      ),
    );
  }

  static void show(BuildContext context) {
    if (_overlayEntry == null) {
      _createOverlayEntry(context);
    }
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.transparentBlack, // Semi-transparent background
      child: Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          color: context.colors.darkGreen,
        ),
      ),
    );
  }
}
