import 'dart:async';
import 'dart:ui';

import 'package:flutter_chart/chart2/base/base_chart_data.dart';
import 'package:flutter_chart/chart2/base/base_chart_painter.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

import 'axis_chart_data.dart';

abstract class AxisChartPainter<D extends AxisChartData>
    extends BaseChartPainter<D> {
  final D data;

  Paint gridPaint, backgroundPaint;

  AxisChartPainter(this.data,{TouchEventNotifier touchEventNotifier}) :
        super(data,touchEventNotifier:touchEventNotifier) {
    gridPaint = Paint()..style = PaintingStyle.stroke;

    backgroundPaint = Paint()..style = PaintingStyle.fill;
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

  double getPixelX(double spotX, Size chartUsableSize) {
    return (((spotX - data.minX) / (data.maxX - data.minX)) * chartUsableSize.width) + getLeftOffsetDrawSize();
  }

  double getPixelY(double spotY, Size chartUsableSize) {
    double y = ((spotY - data.minY) / (data.maxY - data.minY)) * chartUsableSize.height;
    y = chartUsableSize.height - y;
    return y + getTopOffsetDrawSize();
  }
}
