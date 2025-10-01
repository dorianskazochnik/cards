import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

// класс кастомной отрисовки окна диалога
class SpeechBubble extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintmain = Paint()..color = white;
    final rect = Rect.fromLTWH(0, 1, size.width, size.height);
    final radius = Radius.circular(32);
    final roundedRect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(roundedRect, paintmain);
    final paintexl = Paint()..color = black;
    double w = size.width - 64 - 10;
    double h = 0;
    final circle = Offset(w, h + 32);
    canvas.drawCircle(circle, 10.0, paintexl);
    final path = Path();
    path.moveTo(w - 10 - 32, h);
    path.quadraticBezierTo(w - 10, h, w - 10, h + 32);
    path.lineTo(w + 10, h + 32);
    path.lineTo(w + 10 + 32, h);
    path.lineTo(w - 10 - 32, h);
    path.close();
    canvas.drawPath(path, paintexl);
    final circle2 = Offset(size.width - 32, h + 32);
    canvas.drawCircle(circle2, 32.0, paintmain);
    final rect2 = Rect.fromLTWH(size.width - 32, size.height - 31, 32, 32);
    canvas.drawRect(rect2, paintmain);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return false;
  }
}