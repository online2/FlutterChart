import 'base_chart_data.dart';
import 'base_chart_painter.dart';

abstract class BaseChart {
  BaseChartPainter painter();
  BaseChartData getData();
}