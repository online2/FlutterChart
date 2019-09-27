import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/axis/axis_chart_data.dart';

class BaseChartData {
  ChartBorderStyle borderStyle;
  ChartTouchStyle touchStyle;

  BaseChartData({this.borderStyle, this.touchStyle}) {
    borderStyle ??= ChartBorderStyle();
  }
}

class ChartBorderStyle {
  final bool show;
  final bool isShowLeft;
  final bool isShowRight;
  final bool isShowTop;
  final bool isShowBottom;
  Border border;

  ChartBorderStyle({
    this.show = true,
    this.isShowBottom = true,
    this.isShowTop = false,
    this.isShowLeft = true,
    this.isShowRight  = false,
    this.border,
  }) {
    border ??= Border.all(
      color: Colors.black,
      width: 1.0,
      style: BorderStyle.solid,
    );
  }
}

class ChartTitlesStyle {
  final bool show;

  final TitlesStyle leftTitles, topTitles, rightTitles, bottomTitles;

  const ChartTitlesStyle({
    this.show = true,
    this.leftTitles = const TitlesStyle(reservedSize: 40, showTitles: true),
    this.topTitles = const TitlesStyle(reservedSize: 20),
    this.rightTitles = const TitlesStyle(reservedSize: 40),
    this.bottomTitles = const TitlesStyle(reservedSize: 20, showTitles: true),
  });
}

class TitlesStyle {
  final bool showTitles;
  final GetTitleValueFormat getTitlesFormat;
  final double reservedSize;
  final TextStyle textStyle;
  final double margin;

  const TitlesStyle({
    this.showTitles = false,
    this.getTitlesFormat = defaultGetTitle,
    this.reservedSize = 20,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 11,
    ),
    this.margin = 6,
  });
}

typedef GetTitleValueFormat = String Function(double value);

String defaultGetTitle(double value) {
  return '$value';
}

class ChartValueStyle {
  final bool show;
  final TextStyle textStyle;
  final GetValueIsShow checkValueIsShow;
  final GetValueFormat valueFormat;
  final double margin;

  const ChartValueStyle(
      {this.show = false,
      this.textStyle = const TextStyle(
        color: Colors.black,
        fontSize: 10,
      ),
      this.checkValueIsShow = defaultValueIsShow,
      this.valueFormat = defaultValueFormat,
      this.margin = 5});
}

typedef GetValueIsShow = bool Function(ChartPoint value);

typedef GetValueFormat = String Function(ChartPoint value);

bool defaultValueIsShow(ChartPoint point) {
  return true;
}

String defaultValueFormat(ChartPoint point) {
  return point.y.toString();
}

class ChartLegendStyle {
  final bool showLegend;
  final ChartLegendForm chartLegendForm;
  final ChartLegendAlignment chartLegendAlignment;
  final ChartLegendLocation chartLegendLocation;
  final TextStyle textStyle;
  final double margin;
  final List<String> legendText;
  final double legendSize;

  const ChartLegendStyle(
      {this.showLegend = false,
      this.chartLegendForm = ChartLegendForm.SQUARE,
      this.chartLegendAlignment = ChartLegendAlignment.LEFT,
      this.chartLegendLocation = ChartLegendLocation.BOTTOM,
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 10),
      this.margin = 5,
      this.legendText,
      this.legendSize = 20});
}

enum ChartLegendForm { SQUARE, CIRCLE }
enum ChartLegendAlignment { LEFT, RIGHT } //CENTER暂未实现

enum ChartLegendLocation { TOP, BOTTOM }

class ChartTouchStyle {
  final bool enabled;

  const ChartTouchStyle(this.enabled);
}
