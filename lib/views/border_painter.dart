import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  // ========  ========  ========  ========  ========
  // spaceQuantity = 4     dash quantity = 5
  // spaceRatio = 1 / 4    dash ratio = 4 / 4
  // space size = 2        dash size = 8         total size = 48

  // quantity of spaces between dashs
  final int spaceQuantity = 4;
  // proportion of space comparing with dash size
  final double spaceRatio = 1 / 4;

  @override
  void paint(Canvas canvas, Size size) {
    final paintBorder = _getPaintLine(size, 0.03);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          paintBorder.strokeWidth / 2,
          paintBorder.strokeWidth / 2,
          size.width - paintBorder.strokeWidth,
          size.height - paintBorder.strokeWidth,
        ),
        const Radius.circular(1.0),
      ),
      paintBorder,
    );

    final paintDashed = _getPaintLine(size, 0.02);

    final verticalDashSize = size.height / (spaceQuantity * spaceRatio + spaceQuantity + 1);
    for (var i = 0; i < spaceQuantity + 1; i++) {
      final initPosition = i.toDouble() * verticalDashSize + i.toDouble() * verticalDashSize * spaceRatio;
      final endPosition = (i.toDouble() + 1) * verticalDashSize + i.toDouble() * verticalDashSize * spaceRatio;
      canvas.drawLine(Offset(size.width / 2, initPosition), Offset(size.width / 2, endPosition), paintDashed);
    }

    final horizontalDashSize = size.width / (spaceQuantity * spaceRatio + spaceQuantity + 1);
    for (var i = 0; i < spaceQuantity + 1; i++) {
      final initPosition = i.toDouble() * horizontalDashSize + i.toDouble() * horizontalDashSize * spaceRatio;
      final endPosition = (i.toDouble() + 1) * horizontalDashSize + i.toDouble() * horizontalDashSize * spaceRatio;
      canvas.drawLine(Offset(initPosition, size.height / 2), Offset(endPosition, size.height / 2), paintDashed);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Paint _getPaintLine(Size size, double percentWidth) {
    return Paint()
      ..color = Colors.grey[500]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * percentWidth;
  }
}
