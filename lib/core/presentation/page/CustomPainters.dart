import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

class Gap1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintexl = Paint()..color = black;
    double w = (size.width - 5 * 16) / 4 + 48;
    double h = size.height - 70 + 44;
    final circle = Offset(w, h);
    canvas.drawCircle(circle, 32.0, paintexl);
    final path = Path();
    path.moveTo(w - 64, h - 24);
    path.quadraticBezierTo(w - 32, h - 24, w - 32, h);
    path.lineTo(w + 32, h);
    path.quadraticBezierTo(w + 32, h - 24, w + 64, h - 24);
    path.lineTo(w - 64, h - 24);
    path.close();
    canvas.drawPath(path, paintexl);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return false;
  }
}

class Gap3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintexl = Paint()..color = black;
    double w = size.width - (size.width - 5 * 16) / 4 - 16;
    double h = size.height - 70 + 44;
    final circle = Offset(w, h);
    canvas.drawCircle(circle, 32.0, paintexl);
    final path = Path();
    path.moveTo(w - 64, h - 24);
    path.quadraticBezierTo(w - 32, h - 24, w - 32, h);
    path.lineTo(w + 32, h);
    path.quadraticBezierTo(w + 32, h - 24, w + 64, h - 24);
    path.lineTo(w - 64, h - 24);
    path.close();
    canvas.drawPath(path, paintexl);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return false;
  }
}

class Gap2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintexl = Paint()..color = black;
    double w = (size.width - 5 * 16) / 2 + 56;
    double h = size.height - 70 + 44;
    final circle = Offset(w, h);
    canvas.drawCircle(circle, 32.0, paintexl);
    final path = Path();
    path.moveTo(w - 64, h - 24);
    path.quadraticBezierTo(w - 32, h - 24, w - 32, h);
    path.lineTo(w + 32, h);
    path.quadraticBezierTo(w + 32, h - 24, w + 64, h - 24);
    path.lineTo(w - 64, h - 24);
    path.close();
    canvas.drawPath(path, paintexl);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return false;
  }
}