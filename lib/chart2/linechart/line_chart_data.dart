import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/axis/axis_chart_data.dart';
import 'package:flutter_chart/chart2/base/base_chart_data.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

class LineChartData extends AxisChartData {
  final List<LineChartBarData> lineBarsData;
  final ChartTitlesStyle titlesStyle;
  final ChartLegendStyle chartLegendStyle;
  final LineChartTouchStyle lineChartTouchStyle;
  final LimitLineData limitLineData;

  LineChartData({
    this.lineBarsData = const [],
    this.titlesStyle = const ChartTitlesStyle(),
    this.chartLegendStyle = const ChartLegendStyle(),
    this.lineChartTouchStyle = const LineChartTouchStyle(),
    this.limitLineData = const LimitLineData(),
    ChartGridStyle gridData = const ChartGridStyle(),
    ChartBorderStyle borderStyle,
    double minX,
    double maxX,
    double minY,
    double maxY,
    bool clipToBorder = false,
    Color backgroundColor,
  }) : super(
            chartGridStyle: gridData,
            borderStyle: borderStyle,
            clipToBorder: clipToBorder,
            backgroundColor: backgroundColor,
            touchData: lineChartTouchStyle) {
    calculateMaxMin(minX, maxX, minY, maxY);
  }

  void calculateMaxMin(double minX, double maxX, double minY, double maxY) {
    lineBarsData.forEach((lineBarChart) {
      if (lineBarChart.spots == null || lineBarChart.spots.isEmpty) {
        throw Exception('spots could not be null or empty');
      }
    });
    if (lineBarsData.isNotEmpty) {
      var canModifyMinX = false;
      if (minX == null) {
        minX = lineBarsData[0].spots[0].x;
        canModifyMinX = true;
      }

      var canModifyMaxX = false;
      if (maxX == null) {
        maxX = lineBarsData[0].spots[0].x;
        canModifyMaxX = true;
      }

      var canModifyMinY = false;
      if (minY == null) {
        minY = lineBarsData[0].spots[0].y;
        canModifyMinY = true;
      }

      var canModifyMaxY = false;
      if (maxY == null) {
        maxY = lineBarsData[0].spots[0].y;
        canModifyMaxY = true;
      }

      lineBarsData.forEach((barData) {
        barData.spots.forEach((spot) {
          if (canModifyMaxX && spot.x > maxX) {
            maxX = spot.x;
          }

          if (canModifyMinX && spot.x < minX) {
            minX = spot.x;
          }

          if (canModifyMaxY && spot.y > maxY) {
            maxY = spot.y;
          }

          if (canModifyMinY && spot.y < minY) {
            minY = spot.y;
          }
        });
      });
    } else {
      minX = 0;
      maxX = 0;
      minY = 0;
      minX = 0;
    }

    super.minX = minX;
    super.maxX = maxX;
    super.minY = minY;
    super.maxY = maxY;
  }
}

class LineChartBarData {
  final List<ChartPoint> spots;

  //线的模式，直线和贝塞尔曲线
  final LineMode lineMode;

  //线两端是否圆角
  final bool isStrokeCapRound;
  final double lineWidth;
  final List<Color> lineColors;

  //多个渐变色，停止的点
  final List<double> lineColorsStops;

  //贝塞尔曲线的控制计算偏移阀值 默认0.2 : Max = 1f = very cubic, Min = 0.05f = low cubic effect
  final double intensity;

  //线上的点，样式
  final LineDotStyle lineDotStyle;

  //线以内的填充色样式
  final LineFillStyle lineFillStyle;

  //线上Value 值的样式
  final ChartValueStyle chartValueStyle;

  const LineChartBarData(
      {this.spots = const [],
      this.lineMode = LineMode.LINEAR,
      this.isStrokeCapRound,
      this.lineColors = const [Colors.black],
      this.lineColorsStops,
      this.lineWidth = 1,
      this.intensity = 0.2,
      this.lineDotStyle = const LineDotStyle(),
      this.lineFillStyle,
      this.chartValueStyle = const ChartValueStyle()});
}

//线模式，直线和贝塞尔曲线
enum LineMode {
  LINEAR,
  CUBIC_BEZIER,
}

class LineDotStyle {
  final bool show;
  final Color dotColor;
  final double dotSize;
  final bool isStroke;
  final double strokeWidth;

  final CheckToShowDot checkToShowDot;

  const LineDotStyle({
    this.show = true,
    this.isStroke = false,
    this.strokeWidth = 1,
    this.dotColor = Colors.blue,
    this.dotSize = 4.0,
    this.checkToShowDot = showAllDots,
  });
}

typedef CheckToShowDot = bool Function(ChartPoint spot);

bool showAllDots(ChartPoint spot) {
  return true;
}

//线下面的渐变色
class LineFillStyle {
  final bool show;
  final List<Color> colors;

  /// values are available between 0 to 1,
  /// Offset(0, 0) represent the top / left
  /// Offset(1, 1) represent the bottom / right
  final Offset gradientFrom;
  final Offset gradientTo;
  final List<double> gradientColorStops;

  const LineFillStyle({
    this.show = true,
    this.colors = const [Colors.blueGrey],
    this.gradientFrom = const Offset(0, 0),
    this.gradientTo = const Offset(1, 0),
    this.gradientColorStops,
  });
}

class LineTouchedSpot extends TouchedPoint {
  LineChartBarData barData;

  LineTouchedSpot(
    this.barData,
    ChartPoint spot, //点坐标
    Offset offset, //点对应屏幕坐标
     double offsetDiff,//点坐标和触摸点坐标y轴差值
  ) : super(spot, offset, offsetDiff: offsetDiff);

  @override
  Color getColor() {
    return barData.lineColors[0];
  }
}

class LineChartTouchStyle extends ChartTouchStyle {
  final Color indicatorColor;
  final double indicatorWidth;
  final double indicatorThreshold;
  final bool isShowIndicator;
  final TouchTopTicStyle touchTopTicStyle;

  const LineChartTouchStyle(
      {bool enable = true,
      this.indicatorColor = Colors.black,
      this.indicatorWidth = 0.5,
      this.indicatorThreshold = 20,
      this.isShowIndicator = true,
      this.touchTopTicStyle = const TouchTopTicStyle()})
      : super(enable);
}
