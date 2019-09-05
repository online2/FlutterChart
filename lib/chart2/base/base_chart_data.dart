import 'package:flutter/material.dart';

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
    this.rightTitles = const SideTitles(reservedSize: 40,),
    this.bottomTitles = const SideTitles(reservedSize: 22, showTitles: true),
  });
}

class SideTitles {
  final bool showTitles;
  final GetTitleFunction getTitles;
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

typedef GetTitleFunction = String Function(double value);

String defaultGetTitle(double value) {
  return '$value';
}
