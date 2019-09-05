import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/axis/base_axis.dart';
import 'dart:math';
// Canvas学习

class MyPainter extends CustomPainter {
  XAxis mXAxis;
  YAxis mYAxis;
  List<int> x = [1, 2, 3, 4, 5, 6, 7];
  List<int> y = [5, 6, 1, 9, 5, 5, 3];
  List<String> xLabel = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"];

  MyPainter({this.mXAxis, this.mYAxis});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);

    var matrix4 = Matrix4.rotationZ(pi);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        paint);
    paint..color = Colors.black;
    canvas.drawCircle(Offset(0, 0), 5, paint);

    double xCount = size.width / x.length;

    var maxValue = y.reduce(max);
//    var minValue = y.reduce(min) > 0 ? 0 : y.reduce(min);
    var spaceY = size.height / maxValue * 0.75;


    paint
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    //画线点集合
    List<Offset> point = [];
    for (int i = 0; i < x.length; i++) {
      point.add(Offset(i * xCount, size.height - y[i] * spaceY));
    }

    Path path = new Path();
    for (int i = 0; i < point.length; i++) {
      if (i == 0) {
        path.moveTo(point[i].dx, point[i].dy);
      } else {
        path.lineTo(point[i].dx, point[i].dy);
      }
    }


    canvas.drawPath(path, paint);

    paint
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    //画 x 轴网格
    for (int i = 1; i < x.length; i++) {
      canvas.drawLine(
          Offset(i * xCount, 0), Offset(i * xCount, size.height), paint);
    }

    //画x 轴标签
    for (int z = 0; z < xLabel.length; z++) {
      TextSpan span = TextSpan(
          text: xLabel[z], style: TextStyle(fontSize: 10, color: Colors.black));
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout(maxWidth: 20); //不设置这个不展示
      tp.paint(canvas, Offset(z * xCount - 10, size.height));
    }

    //画 y 轴网格
    for (int j = 1; j < size.width / spaceY; j++) {
      canvas.drawLine(
          Offset(0, j * spaceY), Offset(size.width, j * spaceY), paint);
    }
    //画 y 轴标签
    for (int z = 0; z < maxValue * 1.25; z++) {
      TextSpan span = TextSpan(
          text: (z).toString(),
          style: TextStyle(fontSize: 10, color: Colors.black));
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout(maxWidth: 40); //不设置这个不展示
      tp.paint(canvas, Offset(-40, size.height - z * spaceY));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

