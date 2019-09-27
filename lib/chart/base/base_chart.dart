
import 'package:flutter_chart/chart/base/touch_event.dart';

import 'base_chart_data.dart';
import 'base_chart_painter.dart';

abstract class BaseChart {
  BaseChartPainter painter({TouchEventNotifier touchEventNotifier});//,double animPresent
  BaseChartData getData();
}