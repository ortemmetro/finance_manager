import 'dart:math';

import 'package:flutter/material.dart';

class RadialPercentListWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  final Color backgroundColor;
  final Color filledColor;
  final Color unfilledColor;
  final double lineWidth;

  const RadialPercentListWidget({
    Key? key,
    required this.child,
    required this.percent,
    required this.backgroundColor,
    required this.filledColor,
    required this.unfilledColor,
    required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent,
            backgroundColor: backgroundColor,
            filledColor: filledColor,
            unfilledColor: unfilledColor,
            lineWidth: lineWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Center(child: child),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color backgroundColor;
  final Color filledColor;
  final Color unfilledColor;
  final double lineWidth;

  MyPainter({
    required this.percent,
    required this.backgroundColor,
    required this.filledColor,
    required this.unfilledColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = calculateArcsRect(size);

    drawBackground(canvas, size);

    drawUnfilledLine(canvas, arcRect);

    drawFilledLine(canvas, arcRect);
  }

  void drawFilledLine(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = filledColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  void drawUnfilledLine(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = unfilledColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = backgroundColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    final circleMargin = 3;
    final arcOffset = lineWidth / 2 + circleMargin;
    final arcRect = Offset(arcOffset, arcOffset) &
        Size(size.width - arcOffset * 2, size.height - arcOffset * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
