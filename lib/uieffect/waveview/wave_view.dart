import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;

///todo 待新增进度设置高度由0到1变化。多条wave时 对应的正选波形，区别大一点

class WaveView extends StatefulWidget {
  final BorderRadius borderRadius;
  final Color viewBgColor;
  final Size parentWidgetSize; //因为当前控件大小需要build之后才能拿到，所以由父布局传入
  final List<double> waveAmplitude; //帧幅
  final double waveProgress; //进度
  final double waveCount;
  final List<List<Color>> waveColor;
  final Alignment gradientBegin;
  final Alignment gradientEnd;

  WaveView(
      {this.borderRadius = const BorderRadius.all(Radius.circular(20)),
      this.viewBgColor = const Color(0xFFBBDEFB),
      this.parentWidgetSize = const Size(300, 300),
      this.waveAmplitude = const [8, 18, 28],
      this.waveProgress = 0.5,
      this.waveCount = 3,
      this.waveColor = const [
        [Color(0x88BBDEFB), Color(0x8842A5F5)],
        [Color(0x8880CBC4), Color(0x8800897B)],
        [Color(0x88A5D6A7), Color(0x8843A047)]
      ],
      this.gradientBegin = Alignment.bottomRight,
      this.gradientEnd = Alignment.topLeft});

  @override
  _WaveView createState() {
    return _WaveView();
  }
}

class _WaveView extends State<WaveView> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _waveAnimationController;
  List<List<Offset>> waveOffset = [];

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _waveAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _waveAnimationController.addListener(() {
      waveOffset.clear();
      for (int i = 0; i < widget.waveCount; i++) {
        List<Offset> offset = [];
        for (int j = 0; j <= widget.parentWidgetSize.width; j++) {
          offset.add(new Offset(
              j.toDouble(),
              math.sin((_waveAnimationController.value * 360 - j) %
                          360 *
                          vector.degrees2Radians) *
                      widget.waveAmplitude[i] +
                  (widget.parentWidgetSize.height -
                      widget.parentWidgetSize.height * widget.waveProgress)));
        }
        waveOffset.add(offset);
      }
    });
    _waveAnimationController.repeat();
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _waveAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.viewBgColor, borderRadius: widget.borderRadius),
      child: new AnimatedBuilder(
          animation: new CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
          builder: (context, child) {
            return Stack(
              children: crateWave(),
            );
          }),
    );
  }

  List<Widget> crateWave() {
    List<Widget> waveView = [];
    for (int i = 0; i < waveOffset.length; i++) {
      Widget tempWidget = new ClipPath(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              colors: widget.waveColor[i],
              begin: widget.gradientBegin,
              end: widget.gradientEnd,
            ),
          ),
        ),
        clipper: new WaveClipper(_animationController.value, waveOffset[i]),
      );
      waveView.add(tempWidget);
    }

    return waveView;
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList = [];

  WaveClipper(this.animation, this.waveList);

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
