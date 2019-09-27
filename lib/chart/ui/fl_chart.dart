library fl_chart;

import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/base/base_chart.dart';
import 'package:flutter_chart/chart/base/touch_event.dart';


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

class _FlutterChartState extends State<FlutterChart>
    with TickerProviderStateMixin {
  TouchEventNotifier _touchInputNotifier;
  Animation<double> animation;
  AnimationController _controller;
//  TODO 动画的部分先放着，目前会有点卡顿
  double value =1;


  @override
  void initState() {
    super.initState();
    _touchInputNotifier = TouchEventNotifier(null);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent:_controller,curve: Curves.decelerate));
//    _controller.forward();
//    _controller.addListener((){
//      setState(() {
//        value =  _controller.value;
//      });
//    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _touchInputNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//原始事件指针
//    Listener(
//      onPointerDown: (PointerDownEvent d){
//        _touchInputNotifier.value =
//            ChartPressDown(_globalToLocal(context, d.position));
//      },
//    );

    return GestureDetector(
      onTapUp: (d) {
        _touchInputNotifier.value =
            ChartPressUp(_globalToLocal(context, d.globalPosition));
      },
      onTapCancel: () {
        _touchInputNotifier.value = ChartPressUp(null);
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
        _touchInputNotifier.value = ChartPressUp(null);
      },
      onPanCancel: () {
        _touchInputNotifier.value = ChartPressUp(null);
      },
      child: CustomPaint(
        painter: widget.chart.painter(
          touchEventNotifier: _touchInputNotifier,
//          animPresent: value
        ),

      ),
    );
  }

  Offset _globalToLocal(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject();
    return box.globalToLocal(globalPosition);
  }
}
