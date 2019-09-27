import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/axis/axis_chart_data.dart';
import 'package:flutter_chart/chart/base/base_chart_data.dart';
import 'package:flutter_chart/chart/linechart/line_chart.dart';
import 'package:flutter_chart/chart/linechart/line_chart_data.dart';

import 'package:flutter_chart/chart/ui/fl_chart.dart';

class LineChartStyle1 extends StatefulWidget {
  static final String sName = "LineChartStyle1";

  @override
  _LinChartStyle1 createState() {
    return _LinChartStyle1();
  }
}

class _LinChartStyle1 extends State<LineChartStyle1> {
  LineMode lineMode;
  bool isStrokeCapRound;
  List<Color> lineColors;
  bool isLine = true;
  bool isOpenTouchEvent = true;
  bool isShowTopValue = true;
  bool isShowIndicator = true;
  bool isShowLineValue = true;
  bool isShowLineDot = true;
  List<HorizontalLimitLine> limitLine = [];
  double num = 30;

  @override
  void initState() {
    super.initState();
    lineMode = LineMode.CUBIC_BEZIER;
    isStrokeCapRound = true;
    lineColors = [Colors.blue];
    limitLine.add(HorizontalLimitLine(
        y: 25,
        text: "上周平均值25%",
        textMargin: 0,
        textStyle: TextStyle(color: Colors.red, fontSize: 8),
        limitAlignment: HorizontalLimitAlignment.TOP_LEFT,
        color: Colors.red,
        strokeWidth: 0.5));
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
                        drawHorizontalGrid: false,
                        drawVerticalGrid: false,
                        verticalInterval: 10),
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
                          lineColors: [Colors.blue],
                          lineDotStyle: LineDotStyle(
                              show: isShowLineDot,
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
                              show: isShowLineValue,
                              textStyle:
                                  TextStyle(color: Colors.blue, fontSize: 10),
                              valueFormat: ((ChartPoint point) {
                                return point.y.toInt().toString() + "%";
                              }))),
                      LineChartBarData(
                          spots: [
                            ChartPoint(1, 0),
                            ChartPoint(2, 15),
                            ChartPoint(3, 35),
                            ChartPoint(4, 40),
                            ChartPoint(5, 30),
                            ChartPoint(6, 30),
                            ChartPoint(7, 15),
                          ],
                          lineMode: lineMode,
                          isStrokeCapRound: isStrokeCapRound,
                          lineWidth: 4,
                          lineColors: [Colors.red],
                          lineDotStyle: LineDotStyle(
                              show: isShowLineDot,
                              isStroke: false,
                              strokeWidth: 4,
                              dotColor: Colors.red,
                              dotSize: 5,
                              //可以过滤掉一些不需要显示的点
                              checkToShowDot: ((ChartPoint spot) {
                                return true;
                              })),
                          lineFillStyle: LineFillStyle(
                              show: true, colors: [Color(0x66E57373)]),
                          chartValueStyle: ChartValueStyle(
                              show: isShowLineValue,
                              textStyle:
                                  TextStyle(color: Colors.red, fontSize: 10),
                              valueFormat: ((ChartPoint point) {
                                return point.y.toInt().toString() + "%";
                              }))),
                    ],
                    titlesStyle: ChartTitlesStyle(
                        show: true,
                        leftTitles: TitlesStyle(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesFormat: ((double value) {
                              return '${value.toInt()}%';
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
                        legendText: ["每日比增", "上周每日"]),
                    lineChartTouchStyle: LineChartTouchStyle(
                        enable: isOpenTouchEvent,
                        //关闭触摸响应
                        isShowIndicator: isShowIndicator,
                        indicatorColor: Colors.black,
                        indicatorWidth: 0.5,
                        touchTopTicStyle: TouchTopTicStyle(
                            show: isShowTopValue,
                            topTipMargin: 5,
                            topTipEdgInsets: EdgeInsets.all(6),
                            getTopTipText: (ChartPoint point) {
                              return "y = " + point.y.toInt().toString();
                            })),
                    limitLineData: LimitLineData(
                        showHorizontalLines: true,
                        horizontalLines: limitLine)))),
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLine = !isLine;
                    if (isLine) {
                      lineMode = LineMode.LINEAR;
                    } else {
                      lineMode = LineMode.CUBIC_BEZIER;
                    }
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 32, left: 16),
                    width: 90,
                    height: 35,
                    child: Center(
                      child: Text(
                        isLine ? "直线" : "贝塞尔曲线",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOpenTouchEvent = !isOpenTouchEvent;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 32, left: 16),
                    width: 110,
                    height: 35,
                    child: Center(
                      child: Text(
                        isOpenTouchEvent ? "关闭触摸提示" : "打开触摸提示",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowTopValue = !isShowTopValue;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 32, left: 16),
                    width: 110,
                    height: 35,
                    child: Center(
                      child: Text(
                        isShowTopValue ? "关闭点击提示" : "显示点击提示",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              )
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowIndicator = !isShowIndicator;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 16, left: 16),
                    width: 110,
                    height: 35,
                    child: Center(
                      child: Text(
                        isShowIndicator ? "关闭触摸指示器" : "打开触摸指示器",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowLineValue = !isShowLineValue;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 16, left: 16),
                    width: 110,
                    height: 35,
                    child: Center(
                      child: Text(
                        isShowLineValue ? "关闭线上value" : "显示value",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowLineDot = !isShowLineDot;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 16, left: 16),
                    width: 90,
                    height: 35,
                    child: Center(
                      child: Text(
                        isShowLineDot ? "关闭点" : "显示点",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              )
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if(num >60){
                    return;
                  }
                  setState(() {
                    num+=5;
                    limitLine.add(HorizontalLimitLine(
                        y: num,
                        text: "新线"+num.toString() +"%",
                        textMargin: 0,
                        textStyle: TextStyle(color: Colors.red, fontSize: 8),
                        limitAlignment: HorizontalLimitAlignment.TOP_LEFT,
                        color: Colors.red,
                        strokeWidth: 0.5));
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 16, left: 16),
                    width: 90,
                    height: 35,
                    child: Center(
                      child: Text(
                        "添加限制线",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              )
            ],
          )
        ]));
  }
}
