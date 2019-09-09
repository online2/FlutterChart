import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/fl_chart.dart';
import 'package:flutter_chart/chart2/linechart/line_chart.dart';
import 'package:flutter_chart/chart2/linechart/line_chart_data.dart';

import 'chart2/axis/axis_chart_data.dart';
import 'chart2/base/base_chart_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Container(
              width: 300,
              height: 300,
              child: FlChart(
                chart: LineChart(LineChartData(
                  chartLegendStyle: ChartLegendStyle(showLegend: true,textStyle: new TextStyle(color: Colors.red,fontSize: 12),legendText: ["测试1","测试二"]),
                  titlesStyle: ChartTitlesStyle(
                      show: true,
                      leftTitles: TitlesStyle(
                        showTitles: true,
                        reservedSize: 22,
                        textStyle: TextStyle(
                            color: const Color(0xff68737d), fontSize: 10),
                        getTitles: (value) {
                          return "${value.toInt()}K";
                        },
                        margin: 8,
                      ),
                      bottomTitles: TitlesStyle(
                        showTitles: true,
                        reservedSize: 22,
                        textStyle: TextStyle(
                            color: const Color(0xff68737d), fontSize: 10),
                        getTitles: (value) {
                          return "${value.toInt()}";
                        },
                        margin: 8,
                      ),
                      rightTitles: TitlesStyle(
                        showTitles: true,
                        reservedSize: 22,
                        textStyle: TextStyle(
                            color: const Color(0xff68737d), fontSize: 10),
                        getTitles: (value) {
                          return "${value.toInt()}";
                        },
                        margin: 8,
                      ),
                      topTitles: TitlesStyle(
                        showTitles: true,
                        reservedSize: 22,
                        textStyle: TextStyle(
                            color: const Color(0xff68737d), fontSize: 10),
                        getTitles: (value) {
                          return "${value.toInt()}";
                        },
                        margin: 8,
                      )),
                  gridData: ChartGridStyle(
                      show: true,
                      drawXAxisGrid: true,
                      getXAxisGridLine: gridLine2,
                      checkToShowXAxisGrid: (double value) {
                        return value != 0;
                      },
                      drawYAxisGrid: true,
                      getYAxisGridLine: gridLine,
                      checkToShowYAxisGrid: (double value) {
                        return value != 0;
                      }),
                  borderData: ChartBorderStyle(
                      show: true,
                      border: Border.all(
                          color: Colors.yellow,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  minX: 0,
                  maxX: 14,
                  minY: 0,
                  maxY: 5,
//                   backgroundColor: Colors.grey,
                  lineBarsData: [
                    LineChartBarData(
                      chartValueStyle: ChartValueStyle(show: true,textStyle:  TextStyle(color: Colors.black, fontSize: 10,fontWeight: FontWeight.bold),margin:6,valueFormat: (ChartPoint point){
                        return point.y.toInt().toString() +" k";
                      }),
                        spots: [
                          ChartPoint(1, 1),
                          ChartPoint(3, 1.5),
                          ChartPoint(5, 1.4),
                          ChartPoint(7, 3.4),
                          ChartPoint(10, 2),
                          ChartPoint(12, 2.2),
                          ChartPoint(13, 1.8),
                        ],
                        lineMode: LineMode.LINEAR,
                        isStrokeCapRound: false,
                        lineColors: [Colors.red],
                        lineWidth: 10,
                        intensity: 2,
                        lineDotStyle: LineDotStyle(
                            isStroke: false,
                            dotColor: Colors.black,
                            dotSize: 5),
                        lineFillStyle: LineFillStyle(show: true, colors: [
                          Color(0xFFE57373),
                        ])),
                    LineChartBarData(
                        spots: [
                          ChartPoint(1, 2),
                          ChartPoint(3, 2.5),
                          ChartPoint(5, 2.4),
                          ChartPoint(7, 4.4),
                          ChartPoint(10, 3),
                          ChartPoint(12, 3.2),
                          ChartPoint(13, 2.8),
                        ],
                        lineMode: LineMode.CUBIC_BEZIER,
                        isStrokeCapRound: true,
                        lineColors: [
                          Colors.blue,
                          Colors.amberAccent,
                          Colors.green
                        ],
                        lineWidth: 5,
                        intensity: 0.2,
                        lineDotStyle: LineDotStyle(
                            isStroke: true,
                            dotColor: Colors.black,
                            dotSize: 4,
                            strokeWidth: 2),
                        lineFillStyle: LineFillStyle(show: true, colors: [
                          Color(0x8023b6e6),
                          Color(0x8802d39a),
                        ]))
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ChartLine gridLine(double value) {
    return const ChartLine(
      color: Colors.grey,
      strokeWidth: 1,
    );
  }

  ChartLine gridLine2(double value) {
    return const ChartLine(
      color: Colors.red,
      strokeWidth: 1,
    );
  }

  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
}
