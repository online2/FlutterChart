import 'package:flutter/material.dart';
import 'package:flutter_chart/uieffect/waterview/wave_view.dart';
import 'package:flutter_chart/uieffect/waterview/wave_view.dart';

import 'package:flutter_chart/chart/line_chart_1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        LineChartStyle1.sName: (context) => LineChartStyle1(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LineChartStyle1.sName);
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    '线性图表样式1',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
//            WaterView(),
            Container(
              height: 300,
              width: 150,
              child: WaveView(parentWidgetSize: Size(150, 300),),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
