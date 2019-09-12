import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/base/base_chart_painter.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';
import 'package:flutter_chart/chart2/linechart/line_chart_data.dart';

import 'axis_chart_data.dart';

abstract class AxisChartPainter<D extends AxisChartData>
    extends BaseChartPainter<D> {
   final D data;

  Paint gridPaint, backgroundPaint,touchTopTipPaint;

  AxisChartPainter(this.data,{TouchEventNotifier touchEventNotifier}) :
        super(data,touchEventNotifier:touchEventNotifier) {
    gridPaint = Paint()..style = PaintingStyle.stroke;

    backgroundPaint = Paint()..style = PaintingStyle.fill;
    touchTopTipPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    var chartViewSize = getChartDrawSize(size);

    drawBackground(canvas, chartViewSize);
    drawGrid(canvas, chartViewSize);
  }

  void drawGrid(Canvas canvas, Size size) {
    if (!data.chartGridStyle.show || data.chartGridStyle == null) {
      return;
    }
//    绘制竖直线
    if (data.chartGridStyle.drawVerticalGrid) {
      double horizontalStep = data.minX;
      while ( horizontalStep < data.maxX) {
        if (data.chartGridStyle.checkToShowVerticalGrid(horizontalStep)) {
          final ChartLine chartLine = data.chartGridStyle.getVerticalGridLine(horizontalStep);
          gridPaint.color = chartLine.color;
          gridPaint.strokeWidth = chartLine.strokeWidth;
          final double bothX = getPixelX(horizontalStep, size);
          final double x1 = bothX;
          final double y1 = 0 + getTopOffsetDrawSize();
          final double x2 = bothX;
          final double y2 = size.height + getTopOffsetDrawSize();
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), gridPaint);
        }
        horizontalStep += data.chartGridStyle.horizontalInterval;
      }
    }

    //绘制水平线
    if (data.chartGridStyle.drawHorizontalGrid) {
      double verticalStep = data.minY;
      while (verticalStep < data.maxY) {
        if (data.chartGridStyle.checkToShowHorizontalGrid(verticalStep)) {
          final ChartLine chartLine = data.chartGridStyle.getHorizontalGridLine(verticalStep);
          gridPaint.color = chartLine.color;
          gridPaint.strokeWidth = chartLine.strokeWidth;
          final double bothY = getPixelY(verticalStep, size);
          final double x1 = 0 + getLeftOffsetDrawSize();
          final double y1 = bothY;
          final double x2 = size.width + getLeftOffsetDrawSize();
          final double y2 = bothY;
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), gridPaint);
        }
        verticalStep += data.chartGridStyle.verticalInterval;
      }
    }
  }

  void drawBackground(Canvas canvas, Size size) {
    if (data.backgroundColor == null) {
      return;
    }

    backgroundPaint.color = data.backgroundColor;
    canvas.drawRect(
      Rect.fromLTWH(
        getLeftOffsetDrawSize(),
        getTopOffsetDrawSize(),
        size.width,
        size.height,
      ),
      backgroundPaint,
    );
  }

  void drawTouchTopTip(Canvas canvas, Size size, TouchTopTicStyle touchTopTicStyle,List<LineTouchedSpot> touchedSpots) {
    if(touchTopTicStyle == null || !touchTopTicStyle.show){
      return;
    }
    if(touchEventNotifier == null  || touchEventNotifier.value == null){
      return;
    }
//    手指抬起关闭indicatorLine
//    if(touchEventNotifier.value is ChartPressUp){
//      return;
//    }
    if(touchedSpots == null || touchedSpots.isEmpty){
      return;
    }

    final List<TextPainter> textPainter = [];
    for(int i = 0 ;i < touchedSpots.length; i++){
      final TextSpan span = TextSpan(style: touchTopTicStyle.topTipTextStyle, text:touchTopTicStyle.getTopTipText(touchedSpots[i].spot) );
      final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: touchTopTicStyle.maxWidth);
      textPainter.add(tp);
    }

    double biggerWidth = 0;
    double sumTextsHeight = 0;
    for (TextPainter tp in textPainter) {
      if (tp.width > biggerWidth) {
        biggerWidth = tp.width;
      }
      sumTextsHeight += tp.height;
    }
    sumTextsHeight += (textPainter.length - 1) * touchTopTicStyle.topTipMargin;


    final Offset mostTopOffset = touchedSpots.first.offset;

    final double tooltipWidth = biggerWidth + touchTopTicStyle.topTipEdgInsets.horizontal;
    final double tooltipHeight = sumTextsHeight + touchTopTicStyle.topTipEdgInsets.vertical;

    final Rect rect = Rect.fromLTWH(mostTopOffset.dx - (tooltipWidth / 2), mostTopOffset.dy - tooltipHeight - touchTopTicStyle.topTipMargin * 2, tooltipWidth, tooltipHeight);
    final Radius radius = Radius.circular(touchTopTicStyle.topTipRadius);
    final RRect roundedRect = RRect.fromRectAndCorners(rect, topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius);
    touchTopTipPaint.color = touchTopTicStyle.topTipColor;
    canvas.drawRRect(roundedRect, touchTopTipPaint);

    double topPosSeek = touchTopTicStyle.topTipEdgInsets.top;
    for (TextPainter tp in textPainter) {
      final drawOffset = Offset(
        rect.center.dx - (tp.width / 2),
        rect.topCenter.dy + topPosSeek,
      );
      tp.paint(canvas, drawOffset);
      topPosSeek += tp.height;
      topPosSeek += touchTopTicStyle.topTipMargin;
    }

  }






  double getPixelX(double spotX, Size chartUsableSize) {
    return (((spotX - data.minX) / (data.maxX - data.minX)) * chartUsableSize.width) + getLeftOffsetDrawSize();
  }

  double getPixelY(double spotY, Size chartUsableSize) {
    double y = ((spotY - data.minY) / (data.maxY - data.minY)) * chartUsableSize.height;
    y = chartUsableSize.height - y;
    return y + getTopOffsetDrawSize();
  }
}
