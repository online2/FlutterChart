
import 'package:flutter_chart/chart/axis/axis_chart.dart';
import 'package:flutter_chart/chart/base/base_chart_data.dart';
import 'package:flutter_chart/chart/base/base_chart_painter.dart';
import 'package:flutter_chart/chart/base/touch_event.dart';
import 'package:flutter_chart/chart/linechart/line_chart_painter.dart';

import 'line_chart_data.dart';

class LineChart extends AxisChart {
  final LineChartData lineChartData;

  LineChart(this.lineChartData);

  @override
  BaseChartData getData() {
    return lineChartData;
  }

  @override
  BaseChartPainter<BaseChartData> painter({TouchEventNotifier touchEventNotifier}) {//double animPresent
  return LineChartPainter(lineChartData,touchEventNotifier);//this.animPresent
  }


}
