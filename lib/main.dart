import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/line_chart_1.dart';
import 'package:flutter_chart/uieffect/drawlayout/drawlayout_demo.dart';
import 'package:flutter_chart/uieffect/waveview/wave_view_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ui Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        LineChartStyle1.sName: (context) => LineChartStyle1(),
        WaveViewDemo.sName: (context) => WaveViewDemo(),
        DrawLayout.sName: (context) => DrawLayout(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<HomeItemList> homeItemList;

  @override
  void initState() {
    setHomeItemList();
    super.initState();
  }

  void setHomeItemList() {
    homeItemList = [
      HomeItemList("图表UI", () {
        Navigator.pushNamed(context, LineChartStyle1.sName);
      }),
      HomeItemList("WaveView 水波纹", () {
        Navigator.pushNamed(context, WaveViewDemo.sName);
      }),
      HomeItemList("DrawaLayout 抽屉", () {
        Navigator.pushNamed(context, DrawLayout.sName);
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter ui 效果 实现demo"),
      ),
      body: Container(
          child: ListView.builder(itemCount: homeItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return createBuildItem(homeItemList[index]);
              })
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget createBuildItem(HomeItemList item) {
    return GestureDetector(
      onTap: item.onItemClick,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.only(left: 16,right: 16,top: 16),
        child: Center(
          child: Text(
            item.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );

  }
}

class HomeItemList {
  String title;
  Function onItemClick;

  HomeItemList(this.title, this.onItemClick);
}
