import 'package:flutter/material.dart';
import 'package:flutter_chart/uieffect/waveview/wave_view.dart';

class WaveViewDemo extends StatefulWidget {
  static final String sName = "WaveViewDemo";

  @override
  _WaveViewDemo createState() {
    return _WaveViewDemo();
  }
}

class _WaveViewDemo extends State<WaveViewDemo>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WaveView Demo")),
      body: Center(
        child:  Container(
          height: 300,
          width: 150,
          child: WaveView(
            parentWidgetSize: Size(150, 300),
          ),
        ),
      ),
    );
  }

}