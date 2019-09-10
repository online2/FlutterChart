import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/axis/axis_chart_data.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

class BaseChartData {
  ChartBorderStyle borderData;
  ChartTouchData touchData;

  BaseChartData({
    this.borderData,
    this.touchData
  }) {
    borderData ??= ChartBorderStyle();
  }
}

class ChartBorderStyle {
  final bool show;
  Border border;

  ChartBorderStyle({
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
  final GetTitleValueFormat getTitles;
  final double reservedSize;
  final TextStyle textStyle;
  final double margin;

  const TitlesStyle({
    this.showTitles = false,
    this.getTitles = defaultGetTitle,
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
enum ChartLegendAlignment { LEFT, CENTER, RIGHT }
enum ChartLegendLocation { TOP, BOTTOM }


class BaseTouchResponse {
  final TouchEvent touchEvent;

  BaseTouchResponse(this.touchEvent);
}

class ChartTouchData {
  final bool enabled ;


  const ChartTouchData({this.enabled = true});
}