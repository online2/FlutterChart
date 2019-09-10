library fl_chart;

import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/base/touch_event.dart';

import 'base/base_chart.dart';

class FlutterChart extends StatefulWidget {
  final BaseChart chart;

  FlutterChart({
    Key key,
    @required this.chart,
  }) : super(key: key) {
    if (chart == null) {
      throw Exception('chart should not be null');
    }
  }

  @override
  State<StatefulWidget> createState() => _FlutterChartState();
}

class _FlutterChartState extends State<FlutterChart> {
  TouchEventNotifier _touchInputNotifier;

  @override
  void initState() {
    super.initState();
    _touchInputNotifier = TouchEventNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (d) {
        _touchInputNotifier.value =
            ChartPressUp(_globalToLocal(context, d.globalPosition));
      },
      onTapCancel: () {
        _touchInputNotifier.value =  ChartPressUp(null);
      },

      //手指按下时会触发此回调(相对于屏幕),比onTapDown回调早
      onPanDown: (DragDownDetails d) {
        _touchInputNotifier.value =
            ChartPressDown(_globalToLocal(context, d.globalPosition));
      },
      //手指滑动时会触发此回调
      onPanUpdate: (DragUpdateDetails d) {
        _touchInputNotifier.value =
            ChartPressMove(_globalToLocal(context, d.globalPosition));
      },

      //滑动结束时调用，没有滑动时不回调
      //可以得到滑动结束时在x、y轴上的速度 print(e.velocity);
      onPanEnd: (DragEndDetails d) {
        _touchInputNotifier.value =
            ChartPressUp(null);
      },
      onPanCancel: () {
        _touchInputNotifier.value =  ChartPressUp(null);
      },
      child: CustomPaint(
        painter: widget.chart.painter(
          touchEventNotifier: _touchInputNotifier,
        ),

      ),
    );
  }

  Offset _globalToLocal(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject();
    return box.globalToLocal(globalPosition);
  }

  @override
  void dispose() {
    super.dispose();
    _touchInputNotifier.dispose();
  }
}
