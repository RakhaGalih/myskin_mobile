import 'package:flutter/material.dart';

class StripedBorderPainter extends CustomPainter {
  final double stripeWidth;
  final Color stripeColor;
  final double stripeLength;

  StripedBorderPainter({
    required this.stripeWidth,
    required this.stripeColor,
    required this.stripeLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = stripeWidth
      ..style = PaintingStyle.stroke;

    // Draw stripes on each side
    _drawStripedSide(canvas, const Offset(0, 0), Offset(size.width, 0),
        stripeLength, paint, Axis.horizontal); // Top
    _drawStripedSide(
        canvas,
        Offset(0, size.height),
        Offset(size.width, size.height),
        stripeLength,
        paint,
        Axis.horizontal); // Bottom
    _drawStripedSide(canvas, const Offset(0, 0), Offset(0, size.height),
        stripeLength, paint, Axis.vertical); // Left
    _drawStripedSide(
        canvas,
        Offset(size.width, 0),
        Offset(size.width, size.height),
        stripeLength,
        paint,
        Axis.vertical); // Right
  }

  void _drawStripedSide(Canvas canvas, Offset start, Offset end,
      double stripeLength, Paint paint, Axis axis) {
    final totalLength =
        (axis == Axis.horizontal) ? end.dx - start.dx : end.dy - start.dy;
    final steps = totalLength ~/ stripeLength;

    for (int i = 0; i < steps; i++) {
      final isEven = i % 2 == 0;
      paint.color = isEven ? stripeColor : Colors.transparent;

      Offset p1, p2;
      if (axis == Axis.horizontal) {
        p1 = Offset(start.dx + i * stripeLength, start.dy);
        p2 = Offset(start.dx + (i + 1) * stripeLength, start.dy);
      } else {
        p1 = Offset(start.dx, start.dy + i * stripeLength);
        p2 = Offset(start.dx, start.dy + (i + 1) * stripeLength);
      }
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
