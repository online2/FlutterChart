import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/axis/axis_chart_painter.dart';

import 'line_chart_data.dart';
import 'dart:ui' as ui;

class LineChartPainter extends AxisChartPainter {
  final LineChartData data;
  Paint barPaint, dotPaint, dotInnerPaint, fillPaint,valuePaint;

  LineChartPainter(this.data) : super(data) {
    barPaint = Paint()..style = PaintingStyle.stroke;
    dotPaint = Paint()..style = PaintingStyle.fill;
    dotInnerPaint = Paint()..style = PaintingStyle.fill;
    fillPaint = Paint()..style = PaintingStyle.fill;
    valuePaint = Paint();
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    if (data.lineBarsData.isEmpty) {
      return;
    }

    Path cubicPath;
    Path linePath;
    size = getChartDrawSize(size);
    for (var linData in data.lineBarsData) {
      switch (linData.lineMode) {
        case LineMode.LINEAR:
          linePath = drawLineFill(canvas, size, linData);
          break;
        case LineMode.CUBIC_BEZIER:
          cubicPath = drawCubicLineFill(canvas, size, linData);
          break;
      }
    }
    for (var linData in data.lineBarsData) {
      switch (linData.lineMode) {
        case LineMode.LINEAR:
          drawLine(canvas, size, linePath, linData);
          break;
        case LineMode.CUBIC_BEZIER:
          drawLineCubicBezier(canvas, cubicPath, size, linData);
          break;
      }
      drawDots(canvas, size, linData);
      drawValue(canvas,size,linData);
    }
    drawTitle(canvas,size);
  }

  //画直线
  void drawLine(Canvas canvas, Size size, Path linePath, LineChartBarData linData) {
    _setLinePaint(linData, size);

    if (linePath == null) {
      linePath = _generateLinePath(size, linData);
    }
    canvas.drawPath(linePath, barPaint);
  }


  Path drawLineFill(Canvas canvas, Size size, LineChartBarData linData) {
    if (!linData.lineFillData.show) {
      return null;
    }

    var linePath =  _generateLinePath(size, linData);
    var fillPath = Path.from(linePath);

    /// Line To Bottom Right
    double x = getPixelX(linData.spots[linData.spots.length - 1].x, size);
    double y = size.height + getTopOffsetDrawSize();
    fillPath.lineTo(x, y);

    /// Line To Bottom Left
    x = getPixelX(linData.spots[0].x, size);
    y = size.height + getTopOffsetDrawSize();
    fillPath.lineTo(x, y);

    /// Line To Top Left
    x = getPixelX(linData.spots[0].x, size);
    y = getPixelY(linData.spots[0].y, size);
    fillPath.lineTo(x, y);
    fillPath.close();

    if (linData.lineFillData.colors.length == 1) {
      fillPaint.color = linData.lineFillData.colors[0];
      fillPaint.shader = null;
    } else {
      List<double> stops = [];
      if (linData.lineFillData.gradientColorStops == null ||
          linData.lineFillData.gradientColorStops.length !=
              linData.lineFillData.colors.length) {
        linData.lineFillData.colors.asMap().forEach((index, color) {
          double temp = 1.0 / linData.lineFillData.colors.length;
          stops.add(temp * (index + 1));
        });
      } else {
        stops = linData.lineFillData.gradientColorStops;
      }

      var from = linData.lineFillData.gradientFrom;
      var to = linData.lineFillData.gradientTo;
      fillPaint.shader = ui.Gradient.linear(
        Offset(
          getLeftOffsetDrawSize() + (size.width * from.dx),
          getTopOffsetDrawSize() + (size.height * from.dy),
        ),
        Offset(
          getLeftOffsetDrawSize() + (size.width * to.dx),
          getTopOffsetDrawSize() + (size.height * to.dy),
        ),
        linData.lineFillData.colors,
        stops,
      );
    }
    canvas.drawPath(fillPath, fillPaint);

    return linePath;

  }

  //画贝塞尔曲线
  void drawLineCubicBezier(Canvas canvas, Path cubicPath, Size size, LineChartBarData linData) {
    _setLinePaint(linData, size);

    var linePath = cubicPath == null ? _generateCubicLinePath(size, linData) : cubicPath;
    canvas.drawPath(linePath, barPaint);
  }

  Path drawCubicLineFill(Canvas canvas, Size size, LineChartBarData linData) {
    if (!linData.lineFillData.show) {
      return null;
    }
    var linePath = _generateCubicLinePath(size, linData);
    var fillPath = Path.from(linePath);

    /// Line To Bottom Right
    double x = getPixelX(linData.spots[linData.spots.length - 1].x, size);
    double y = size.height + getTopOffsetDrawSize();
    fillPath.lineTo(x, y);

    /// Line To Bottom Left
    x = getPixelX(linData.spots[0].x, size);
    y = size.height + getTopOffsetDrawSize();
    fillPath.lineTo(x, y);

    /// Line To Top Left
    x = getPixelX(linData.spots[0].x, size);
    y = getPixelY(linData.spots[0].y, size);
    fillPath.lineTo(x, y);
    fillPath.close();

    if (linData.lineFillData.colors.length == 1) {
      fillPaint.color = linData.lineFillData.colors[0];
      fillPaint.shader = null;
    } else {
      List<double> stops = [];
      if (linData.lineFillData.gradientColorStops == null ||
          linData.lineFillData.gradientColorStops.length !=
              linData.lineFillData.colors.length) {
        linData.lineFillData.colors.asMap().forEach((index, color) {
          double temp = 1.0 / linData.lineFillData.colors.length;
          stops.add(temp * (index + 1));
        });
      } else {
        stops = linData.lineFillData.gradientColorStops;
      }

      var from = linData.lineFillData.gradientFrom;
      var to = linData.lineFillData.gradientTo;
      fillPaint.shader = ui.Gradient.linear(
        Offset(
          getLeftOffsetDrawSize() + (size.width * from.dx),
          getTopOffsetDrawSize() + (size.height * from.dy),
        ),
        Offset(
          getLeftOffsetDrawSize() + (size.width * to.dx),
          getTopOffsetDrawSize() + (size.height * to.dy),
        ),
        linData.lineFillData.colors,
        stops,
      );
    }
    canvas.drawPath(fillPath, fillPaint);
    return linePath;
  }

  //画线上的点
  void drawDots(Canvas canvas, Size size, LineChartBarData linData) {
    if (!linData.dotData.show) {
      return;
    }
    linData.spots.forEach((spot) {
      if (linData.dotData.checkToShowDot(spot)) {
        dotPaint.style = linData.dotData.isStroke ? PaintingStyle.stroke : PaintingStyle.fill;
        var pixelX = getPixelX(spot.x, size);
        var pixelY = getPixelY(spot.y, size);
        //为了点中间不显示线，画了一个以画布为背景的实心圆
        if (linData.dotData.isStroke) {
          dotPaint.strokeWidth = linData.dotData.strokeWidth;
          dotInnerPaint.color = data.backgroundColor == null ? Colors.white : data.backgroundColor;
          canvas.drawCircle(Offset(pixelX, pixelY), linData.dotData.dotSize, dotInnerPaint);
        }
        dotPaint.color = linData.dotData.dotColor;
        canvas.drawCircle(Offset(pixelX, pixelY), linData.dotData.dotSize, dotPaint);
      }
    });
  }

  //画点上面的值
  void drawValue(Canvas canvas, Size size, LineChartBarData linData) {
    if(!linData.chartValue.show){
      return;
    }
    linData.spots.forEach((spot){
      if(linData.chartValue.checkValueIsShow(spot)){
        var pixelX = getPixelX(spot.x, size);
        var pixelY = getPixelY(spot.y, size);
        var valueFormat = linData.chartValue.valueFormat(spot);
        TextSpan span = TextSpan(style:  linData.chartValue.textStyle,text: valueFormat);

        final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
        tp.layout();
        pixelX -= tp.width/2 ;
        pixelY -= tp.height + linData.chartValue.margin;
        tp.paint(canvas, Offset(pixelX, pixelY));

      }

    });
  }


  //画上下左右label
  void drawTitle(Canvas canvas, Size size) {
    if(!data.titlesData.show){
      return;
    }

    final leftTitle = data.titlesData.leftTitles;
    if(leftTitle.showTitles){
      double verticalStep = data.minY;
      while(verticalStep<=data.maxY){
        double x = 0 + getLeftOffsetDrawSize();
        double y =  getPixelY(verticalStep, size);
        final text = leftTitle.getTitles((verticalStep));
        TextSpan span = TextSpan(style: leftTitle.textStyle,text: text);
        final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: getHorizontalSpace());
        x -= tp.width + leftTitle.margin;
        y -= tp.height / 2;
        tp.paint(canvas, Offset(x, y));

        verticalStep += data.chartGridData.verticalInterval;
      }
    }


    final rightTitles = data.titlesData.rightTitles;
    if(rightTitles.showTitles){
      double verticalStep = data.minY;
      while(verticalStep<=data.maxY){
        double x = size.width + getLeftOffsetDrawSize();
        double y =  getPixelY(verticalStep, size);
        final text = leftTitle.getTitles((verticalStep));
        TextSpan span = TextSpan(style: rightTitles.textStyle,text: text);
        final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: getHorizontalSpace());
        x += rightTitles.margin;
        y -= tp.height / 2;
        tp.paint(canvas, Offset(x, y));

        verticalStep += data.chartGridData.verticalInterval;
      }
    }


    final topTitle = data.titlesData.topTitles;
    if(topTitle.showTitles){
      double verticalStep = data.minX;
      while(verticalStep<=data.maxX){
        double x = getPixelX(verticalStep, size);
        double y = 0 +getTopOffsetDrawSize();
        final text = topTitle.getTitles((verticalStep));
        TextSpan span = TextSpan(style: topTitle.textStyle,text: text);
        final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
        tp.layout();
        x -= tp.width / 2;
        y -= tp.height +topTitle.margin;
        tp.paint(canvas, Offset(x, y));
        verticalStep += data.chartGridData.horizontalInterval;
      }
    }


    final bottomTitle = data.titlesData.bottomTitles;
    if(bottomTitle.showTitles){
      double verticalStep = data.minX;
      while(verticalStep<=data.maxX){
        double x = getPixelX(verticalStep, size);
        double y = size.height +getTopOffsetDrawSize();

        final text = bottomTitle.getTitles((verticalStep));

        TextSpan span = TextSpan(style: bottomTitle.textStyle,text: text);
        final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
        tp.layout();
        x -= tp.width / 2;
        y += tp.height / 2;
        tp.paint(canvas, Offset(x, y));

        verticalStep += data.chartGridData.horizontalInterval;

     }
    }
  }


  void _setLinePaint(LineChartBarData linData, Size size) {
    barPaint.strokeCap =
        linData.isStrokeCapRound ? StrokeCap.round : StrokeCap.butt;
    barPaint.strokeWidth = linData.lineWidth;
    if (linData.lineColors.length == 1) {
      //纯色
      barPaint.color = linData.lineColors[0];
      barPaint.shader = null;
    } else {
      List<double> stops = [];
      if (linData.lineColorsStops == null ||
          linData.lineColors.length != linData.lineColorsStops.length) {
        linData.lineColors.asMap().forEach((index, color) {
          double temp = 1 / linData.lineColors.length;
          stops.add(temp * (index + 1));
        });
      } else {
        stops = linData.lineColorsStops;
      }
      //      var linearGradient = LinearGradient(colors: linData.lineColors,stops: stops,begin: Alignment.centerLeft,end: Alignment.centerRight).createShader(rect);
      barPaint.shader = ui.Gradient.linear(
        Offset(
          getLeftOffsetDrawSize(),
          getTopOffsetDrawSize() + (size.height / 2),
        ),
        Offset(
          getLeftOffsetDrawSize() + size.width,
          getTopOffsetDrawSize() + (size.height / 2),
        ),
        linData.lineColors,
        stops,
      );
    }
  }

  Path _generateCubicLinePath(Size size, LineChartBarData linData) {
    double intensity = (linData.intensity > 1 ? 1 : linData.intensity) < 0.05 ? 0.05 : linData.intensity;
    double prevDx = 0;
    double prevDy = 0;
    double curDx = 0;
    double curDy = 0;

    Path path = Path();
    path.reset();

    //第一个点
    Offset prev = Offset(getPixelX(linData.spots[0].x, size), getPixelY(linData.spots[0].y, size));
    path.moveTo(prev.dx, prev.dy);

    int length = linData.spots.length;

    for (int i = 1; i < length; i++) {
      /// 当前点
      final current = Offset(
        getPixelX(linData.spots[i].x, size),
        getPixelY(linData.spots[i].y, size),
      );

      /// 下一个点
      final next = Offset(
        getPixelX(linData.spots[i + 1 < length ? i + 1 : i].x, size),
        getPixelY(linData.spots[i + 1 < length ? i + 1 : i].y, size),
      );

      prevDx = (current.dx - prev.dx) * intensity;
      prevDy = (current.dy - prev.dy) * intensity;
      curDx = (next.dx - current.dx) * intensity;
      curDy = (next.dy - current.dy) * intensity;

      path.cubicTo(prev.dx + prevDx, prev.dy + prevDy, current.dx - curDx,
          current.dy - curDy, current.dx, current.dy);
      prev = current;
    }
    return path;
  }

  Path _generateLinePath(Size size, LineChartBarData linData) {
    var linePath = Path();
    Offset prev = Offset(getPixelX(linData.spots[0].x, size), getPixelY(linData.spots[0].y, size));
    linePath.moveTo(prev.dx, prev.dy);
    int length = linData.spots.length;
    for (int i = 1; i < length; i++) {
      final current = Offset(
        getPixelX(linData.spots[i].x, size),
        getPixelY(linData.spots[i].y, size),
      );
      linePath.lineTo(current.dx, current.dy);
    }
    return linePath;
  }





  @override
  double getHorizontalSpace() {
    double sum = super.getHorizontalSpace();
    if (data.titlesData.show) {

      final leftSide = data.titlesData.leftTitles;
      if (leftSide.showTitles) {
        sum += leftSide.reservedSize + leftSide.margin;
      }

      final rightSide = data.titlesData.rightTitles;
      if (rightSide.showTitles) {
        sum += rightSide.reservedSize + rightSide.margin;
      }

    }
    return sum;
  }

  @override
  double getVerticalSpace() {
    double sum = super.getVerticalSpace();
    if (data.titlesData.show) {

      final topSide = data.titlesData.topTitles;
      if (topSide.showTitles) {
        sum += topSide.reservedSize + topSide.margin;
      }

      final bottomSide = data.titlesData.bottomTitles;
      if (bottomSide.showTitles) {
        sum += bottomSide.reservedSize + bottomSide.margin;
      }

    }
    return sum;
  }

  @override
  double getLeftOffsetDrawSize() {
    var sum = super.getLeftOffsetDrawSize();

    final leftTitles = data.titlesData.leftTitles;
    if (data.titlesData.show && leftTitles.showTitles) {
      sum += leftTitles.reservedSize + leftTitles.margin;
    }
    return sum;
  }

  @override
  double getTopOffsetDrawSize() {
    var sum = super.getTopOffsetDrawSize();

    final topTitles = data.titlesData.topTitles;
    if (data.titlesData.show && topTitles.showTitles) {
      sum += topTitles.reservedSize + topTitles.margin;
    }

    return sum;
  }

}
