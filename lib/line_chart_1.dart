import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/chart2/axis/axis_chart_data.dart';
import 'package:flutter_chart/chart2/base/base_chart_data.dart';
import 'package:flutter_chart/chart2/linechart/line_chart.dart';
import 'package:flutter_chart/chart2/linechart/line_chart_data.dart';

import 'chart2/fl_chart.dart';

class LineChartStyle1 extends StatefulWidget {
  @override
  _LinChartStyle1 createState() {
    return _LinChartStyle1();
  }
}

class _LinChartStyle1 extends State<LineChartStyle1> {
  LineMode lineMode;
  bool isStrokeCapRound;
  List<Color> lineColors;

  @override
  void initState() {
    super.initState();
    lineMode = LineMode.CUBIC_BEZIER;
    isStrokeCapRound = true;
    lineColors = [Colors.blue];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LinChartStyle-1"),
        ),
        body: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            height: 300,
            width: MediaQuery.of(context).size.width - 32,
            child: FlutterChart(
                chart: LineChart(LineChartData(
                    gridData: ChartGridStyle(
                        drawHorizontalGrid:false, drawVerticalGrid: false),
                    borderStyle: ChartBorderStyle(
                        show: true,
                        isShowBottom: true,
                        isShowLeft: true,
                        isShowRight: false,
                        isShowTop: false),
                    minX: 1,
                    maxX: 7,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                          spots: [
                            ChartPoint(1, 0),
                            ChartPoint(2, 20),
                            ChartPoint(3, 25),
                            ChartPoint(4, 35),
                            ChartPoint(5, 20),
                            ChartPoint(6, 15),
                            ChartPoint(7, 45),
                          ],
                          lineMode: lineMode,
                          isStrokeCapRound: isStrokeCapRound,
                          lineWidth: 4,
                          lineColors: lineColors,
                          lineDotStyle: LineDotStyle(
                              isStroke: true,
                              strokeWidth: 4,
                              dotColor: Colors.blue,
                              dotSize: 4,
                              //可以过滤掉一些不需要显示的点
                              checkToShowDot: ((ChartPoint spot) {
                                return true;
                              })),
                          lineFillStyle: LineFillStyle(
                              show: true, colors: [Color(0x66E3F2FD)]),
                          chartValueStyle: ChartValueStyle(
                              show: true,
                              textStyle:
                                  TextStyle(color: Colors.blue, fontSize: 10),
                              valueFormat: ((ChartPoint point) {
                                return point.y.toInt().toString() + "%";
                              }))),
                    ],
                    titlesStyle: ChartTitlesStyle(
                        show: true,
                        leftTitles: TitlesStyle(
                            showTitles: true,
                            getTitlesFormat: ((double value) {
                              return '$value%';
                            })),
                        bottomTitles: TitlesStyle(
                            showTitles: true,
                            textStyle:
                                TextStyle(color: Colors.blue, fontSize: 12),
                            getTitlesFormat: ((double value) {
                              return '${value.toInt()}店';
                            })),
                        topTitles: TitlesStyle(showTitles: false),
                        rightTitles: TitlesStyle(showTitles: false)),
                    chartLegendStyle: ChartLegendStyle(
                        showLegend: true,
                        textStyle: TextStyle(color: Colors.blue, fontSize: 12),
                        chartLegendForm: ChartLegendForm.CIRCLE,
                        chartLegendAlignment: ChartLegendAlignment.RIGHT,
                        chartLegendLocation: ChartLegendLocation.BOTTOM,
                        legendText: ["每日比增"]),
                    lineChartTouchStyle: LineChartTouchStyle(
                        enable: false,//关闭触摸响应
                        indicatorColor: Colors.black,
                        indicatorWidth: 0.5),
                    limitLineData: LimitLineData(
                        showHorizontalLines: true,
                        horizontalLines: [
                          HorizontalLimitLine(
                              y: 25,
                              text: "上周平均值25%",
                              textMargin: 0,
                              textStyle:
                                  TextStyle(color: Colors.red, fontSize: 8),
                              limitAlignment: HorizontalLimitAlignment.TOP_LEFT,
                              color: Colors.red,
                              strokeWidth: 0.5)
                        ],
                        showVerticalLines: false)))),
          )
        ]));
  }
}
