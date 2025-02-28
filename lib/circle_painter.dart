import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A class that extends the [CustomPainter] to paint the requested circle
/// First two define the  animated value and up value. Other ones for
/// controlling the animation moves.
/// Also this class has [backgroundColor] and [progressColor] to control these colors.
class CirclePainter extends CustomPainter {
  final Color? progressColor;
  final Color? backgroundColor;
  final double progressNumber;
  final int maxNumber;
  final double fraction;
  final Animation<double> animation;
  late Paint _paint;

  /// The [CirclePainter] constructor has four required parameters that are [progressNumber],
  /// [maxNumber], [fraction] and [animation].
  CirclePainter(
      {required this.progressNumber,
      required this.maxNumber,
      required this.fraction,
      required this.animation,
      this.backgroundColor,
      this.progressColor}) {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
  }

  /// The [paint] method is called whenever the custom object needs to be repainted.
  /// This method make actual painting according to given values.
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    _paint.color = backgroundColor ?? Colors.black12;
    canvas.drawArc(Offset.zero & size, -math.pi * 1.5 + math.pi / 4, (3 * math.pi) / 2, false, _paint);

    _paint.color = progressColor ?? Colors.black;
    _paint.shader = LinearGradient(stops: [
      0.1,
      0.4,
      0.6,
      0.8
    ], colors: [
      Color(0xFF1378D7),
      Color(0xFF3C54B3),
      Color(0xFF474AA9),
      Color(0xFF652F8F)
    ]).createShader(rect);

    double progressRadians = ((progressNumber / maxNumber) * (3 * math.pi / 2) * (-animation.value));
    double startAngle = (-math.pi * 1.5 + math.pi / 4);

    canvas.drawArc(Offset.zero & size, startAngle, -progressRadians, false, _paint);
  }

  /// The [shouldRepaint] method is called when a new instance of the class
  /// is provided, to check if the new instance actually represents different
  /// information.
  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
