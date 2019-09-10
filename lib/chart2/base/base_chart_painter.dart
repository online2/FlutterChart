import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

import 'base_chart_data.dart';

abstract class BaseChartPainter<D extends BaseChartData> extends CustomPainter {
  final D data;
  Paint borderPaint;
  TouchEventNotifier touchEventNotifier;
  BaseChartPainter(this.data,{this.touchEventNotifier}):
        super(repaint: data.touchData.enabled ? touchEventNotifier : null) {//这边是触摸事件重绘的关键代码。repaint：xxxx
    borderPaint = Paint()..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawViewBorder(canvas,size);
  }

  void drawViewBorder(Canvas canvas, Size size) {
    if(!(data.borderData?.show ?? false)){
      return;
    }
    var chartViewSize = getChartDrawSize(size);


    var topLeft = Offset(getLeftOffsetDrawSize(), getTopOffsetDrawSize());
    var topRight = Offset(getLeftOffsetDrawSize() + chartViewSize.width, getTopOffsetDrawSize());
    var bottomLeft = Offset(getLeftOffsetDrawSize(), getTopOffsetDrawSize() + chartViewSize.height);
    var bottomRight = Offset(getLeftOffsetDrawSize() + chartViewSize.width, getTopOffsetDrawSize() + chartViewSize.height);

    /// Draw Top Line
    borderPaint.color = data.borderData.border.top.color;
    borderPaint.strokeWidth = data.borderData.border.top.width;
    canvas.drawLine(topLeft, topRight, borderPaint);

    /// Draw Right Line
    borderPaint.color = data.borderData.border.right.color;
    borderPaint.strokeWidth = data.borderData.border.right.width;
    canvas.drawLine(topRight, bottomRight, borderPaint);

    /// Draw Bottom Line
    borderPaint.color = data.borderData.border.bottom.color;
    borderPaint.strokeWidth = data.borderData.border.bottom.width;
    canvas.drawLine(bottomRight, bottomLeft, borderPaint);

    /// Draw Left Line
    borderPaint.color = data.borderData.border.left.color;
    borderPaint.strokeWidth = data.borderData.border.left.width;
    canvas.drawLine(bottomLeft, topLeft, borderPaint);

  }



  Size getChartDrawSize(Size size) {
    double newWidth = size.width - getHorizontalSpace();
    double newHeight = size.height - getVerticalSpace();
    return Size(newWidth, newHeight);
  }



  double getHorizontalSpace() => 0;

  double getVerticalSpace() => 0;

  double getLeftOffsetDrawSize() => 0;

  double getTopOffsetDrawSize() => 0;
}



