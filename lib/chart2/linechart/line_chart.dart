import 'dart:async';

import 'package:flutter_chart/chart2/axis/axis_chart.dart';
import 'package:flutter_chart/chart2/base/base_chart_data.dart';
import 'package:flutter_chart/chart2/base/base_chart_painter.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';
import 'package:flutter_chart/chart2/linechart/line_chart_painter.dart';

import 'line_chart_data.dart';

class LineChart extends AxisChart {
  final LineChartData lineChartData;

  LineChart(this.lineChartData);

  @override
  BaseChartData getData() {
    return lineChartData;
  }

  @override
  BaseChartPainter<BaseChartData> painter({TouchEventNotifier touchEventNotifier}) {
  return LineChartPainter(lineChartData,touchEventNotifier);
  }


}
