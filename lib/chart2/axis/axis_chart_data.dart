import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/base/base_chart_data.dart';

class AxisChartData extends BaseChartData {
  final ChartGridData chartGridData;
  double minX, maxX;
  double minY, maxY;
  bool clipToBorder;
  Color backgroundColor;

  AxisChartData({
    this.chartGridData = const ChartGridData(),
    ChartBorderData borderData,
    this.minX, this.maxX,
    this.minY, this.maxY,
    this.clipToBorder = false,
    this.backgroundColor,
  }) : super(borderData: borderData);
}


//分割线相关
typedef GetGridLine = ChartLine Function(double value);

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

class ChartGridData {
  final bool show;

  // XAxisGrid
  final bool drawXAxisGrid;
  final double horizontalInterval;
  final GetGridLine getXAxisGridLine;
  final CheckToShowGrid checkToShowXAxisGrid;

  // YAxisGrid
  final bool drawYAxisGrid;
  final double verticalInterval;
  final GetGridLine getYAxisGridLine;
  final CheckToShowGrid checkToShowYAxisGrid;

  const ChartGridData({
    this.show = true,
    this.drawXAxisGrid = false,
    this.horizontalInterval = 1.0,
    this.getXAxisGridLine = defaultGridLine,
    this.checkToShowXAxisGrid = showAllGrids,

    this.drawYAxisGrid = true,
    this.verticalInterval = 1.0,
    this.getYAxisGridLine = defaultGridLine,
    this.checkToShowYAxisGrid = showAllGrids,
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


