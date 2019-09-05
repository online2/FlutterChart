library fl_chart;

import 'package:flutter/material.dart';

import 'base/base_chart.dart';


class FlChart extends StatefulWidget {
  final BaseChart chart;

  FlChart({
    Key key,
    @required this.chart,
  }) : super(key: key) {
    if (chart == null) {
      throw Exception('chart should not be null');
    }
  }

  @override
  State<StatefulWidget> createState() => _FlChartState();
}

class _FlChartState extends State<FlChart> {

  ///We will notify Touch Events through this Notifier in form of a [FlTouchInput],
  ///then the painter returns touched details through a StreamSink.a

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(
        painter:widget.chart.painter(),
      ),
    );
  }


}