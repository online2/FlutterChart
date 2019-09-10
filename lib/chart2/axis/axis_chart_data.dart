import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/base/base_chart_data.dart';

class AxisChartData extends BaseChartData {
  final ChartGridStyle chartGridStyle;
  double minX, maxX;
  double minY, maxY;
  bool clipToBorder;
  Color backgroundColor;

  AxisChartData({
    this.chartGridStyle = const ChartGridStyle(),
    ChartBorderStyle borderStyle,
    ChartTouchStyle touchData,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.clipToBorder = false,
    this.backgroundColor,
  }) : super(borderStyle: borderStyle, touchStyle: touchData);
}

//分割线相关
typedef GetShowGridLine = ChartLine Function(double value);

ChartLine defaultGridLine(double value) {
  return const ChartLine(
    color: Colors.grey,
    strokeWidth: 0.5,
  );
}

//通过这个过滤一些不需要绘制的 分割线 比如与x轴和y轴重合
typedef CheckToShowGrid = bool Function(double value);

bool showAllGrids(double value) {
  return true;
}

class ChartGridStyle {
  final bool show;

  // 水平方向的分割线
  final bool drawHorizontalGrid;
  final double horizontalInterval;
  final GetShowGridLine getHorizontalGridLine;
  final CheckToShowGrid checkToShowHorizontalGrid;

  // 竖直方向的分割线
  final bool drawVerticalGrid;
  final double verticalInterval;
  final GetShowGridLine getVerticalGridLine;
  final CheckToShowGrid checkToShowVerticalGrid;

  const ChartGridStyle({
    this.show = true,
    this.drawHorizontalGrid = false,
    this.horizontalInterval = 1.0,
    this.getHorizontalGridLine = defaultGridLine,
    this.checkToShowHorizontalGrid = showAllGrids,
    this.drawVerticalGrid = true,
    this.verticalInterval = 1.0,
    this.getVerticalGridLine = defaultGridLine,
    this.checkToShowVerticalGrid = showAllGrids,
  });
}

class ChartLine {
  final Color color;
  final double strokeWidth;

  const ChartLine({
    this.color = Colors.black,
    this.strokeWidth = 2,
  });
}

//点的坐标
class ChartPoint {
  final double x;
  final double y;

  const ChartPoint(this.x, this.y);

  ChartPoint copyWith({
    double x,
    double y,
  }) {
    return ChartPoint(
      x ?? this.x,
      y ?? this.y,
    );
  }
}

abstract class TouchedPoint {
  final ChartPoint spot;
  final Offset offset;

  TouchedPoint(
    this.spot,
    this.offset,
  );

  Color getColor();
}

class LimitLineData {
  final bool showHorizontalLines;
  final bool showHorizontalLimitTip;
  final List<HorizontalLimitLine> horizontalLines;

  final bool showVerticalLines;
  final List<VerticalLimitLine> verticalLines;

  const LimitLineData(
      {this.showHorizontalLines = true,
      this.showHorizontalLimitTip = true,
      this.horizontalLines = const [],
      this.showVerticalLines = false,
      this.verticalLines = const []});
}

class HorizontalLimitLine extends ChartLine {
  final double y;
  final TextStyle textStyle;
  final String text;
  final double textMargin;
  final HorizontalLimitAlignment limitAlignment;

  HorizontalLimitLine(
      {this.y,
      Color color,
      double strokeWidth,
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 10),
      this.text,
      this.textMargin = 5,
      this.limitAlignment = HorizontalLimitAlignment.BOTTOM_CENTER})
      : super(color: color, strokeWidth: strokeWidth);
}

class VerticalLimitLine extends ChartLine {
  final double x;

  VerticalLimitLine({this.x, Color color, double strokeWidth})
      : super(color: color, strokeWidth: strokeWidth);
}

enum HorizontalLimitAlignment { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT,TOP_CENTER,BOTTOM_CENTER }
