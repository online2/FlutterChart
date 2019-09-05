import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/axis/axis_chart_data.dart';

class BaseChartData {
  ChartBorderData borderData;

  BaseChartData({
    this.borderData,
  }) {
    borderData ??= ChartBorderData();
  }
}

class ChartBorderData {
  final bool show;
  Border border;

  ChartBorderData({
    this.show = true,
    this.border,
  }) {
    border ??= Border.all(
      color: Colors.black,
      width: 1.0,
      style: BorderStyle.solid,
    );
  }
}

class ChartTitlesData {
  final bool show;

  final SideTitles leftTitles, topTitles, rightTitles, bottomTitles;

  const ChartTitlesData({
    this.show = true,
    this.leftTitles = const SideTitles(reservedSize: 40, showTitles: true),
    this.topTitles = const SideTitles(reservedSize: 6),
    this.rightTitles = const SideTitles(
      reservedSize: 40,
    ),
    this.bottomTitles = const SideTitles(reservedSize: 22, showTitles: true),
  });
}

class SideTitles {
  final bool showTitles;
  final GetTitleValueFormat getTitles;
  final double reservedSize;
  final TextStyle textStyle;
  final double margin;

  const SideTitles({
    this.showTitles = false,
    this.getTitles = defaultGetTitle,
    this.reservedSize = 22,
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

class ChartValue {
  final bool show;
  final TextStyle textStyle;
  final GetValueIsShow checkValueIsShow;
  final GetValueFormat valueFormat;
  final double margin;

  const ChartValue(
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
