import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

import 'base_chart_data.dart';

abstract class BaseChartPainter<D extends BaseChartData> extends CustomPainter {
  final D data;
  Paint borderPaint;
  TouchEventNotifier touchEventNotifier;
  BaseChartPainter(this.data,{this.touchEventNotifier}):
        super(repaint: data.touchStyle.enabled ? touchEventNotifier : null) {//这边是触摸事件重绘的关键代码。repaint：xxxx
    borderPaint = Paint()..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawViewBorder(canvas,size);
  }

  void drawViewBorder(Canvas canvas, Size size) {
    if(!(data.borderStyle?.show ?? false)){
      return;
    }
    var chartViewSize = getChartDrawSize(size);


    var topLeft = Offset(getLeftOffsetDrawSize(), getTopOffsetDrawSize());
    var topRight = Offset(getLeftOffsetDrawSize() + chartViewSize.width, getTopOffsetDrawSize());
    var bottomLeft = Offset(getLeftOffsetDrawSize(), getTopOffsetDrawSize() + chartViewSize.height);
    var bottomRight = Offset(getLeftOffsetDrawSize() + chartViewSize.width, getTopOffsetDrawSize() + chartViewSize.height);

    if(data.borderStyle.isShowTop){
      borderPaint.color = data.borderStyle.border.top.color;
      borderPaint.strokeWidth = data.borderStyle.border.top.width;
      canvas.drawLine(topLeft, topRight, borderPaint);
    }
    if(data.borderStyle.isShowRight){
      borderPaint.color = data.borderStyle.border.right.color;
      borderPaint.strokeWidth = data.borderStyle.border.right.width;
      canvas.drawLine(topRight, bottomRight, borderPaint);
    }

    if(data.borderStyle.isShowBottom){
      borderPaint.color = data.borderStyle.border.bottom.color;
      borderPaint.strokeWidth = data.borderStyle.border.bottom.width;
      canvas.drawLine(bottomRight, bottomLeft, borderPaint);
    }

    if(data.borderStyle.isShowLeft){
      borderPaint.color = data.borderStyle.border.left.color;
      borderPaint.strokeWidth = data.borderStyle.border.left.width;
      canvas.drawLine(bottomLeft, topLeft, borderPaint);
    }
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



