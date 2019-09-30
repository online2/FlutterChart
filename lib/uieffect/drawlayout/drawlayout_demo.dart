import 'package:flutter/material.dart';
import 'package:flutter_chart/uieffect/waveview/wave_view.dart';

class DrawLayout extends StatefulWidget {
  static final String sName = "DrawLayout";

  @override
  _DrawLayout createState() {
    return _DrawLayout();
  }
}

class _DrawLayout extends State<DrawLayout> {
  @override
  Widget build(BuildContext context) {
//    Widget head = UserAccountsDrawerHeader(
//      margin: EdgeInsets.only(
//          left: 16,
//          right: 16,
//          bottom: 16,
//          top: MediaQuery.of(context).padding.top + 16),
//      accountName: Text("Linfc"),
//      accountEmail: Text("1018596566@qq.com"),
//      currentAccountPicture: CircleAvatar(
//        backgroundImage: AssetImage("image/avater.png"),
//        radius: 40,
//      ),
//    );

    return Scaffold(
      appBar: AppBar(title: Text("DrawLayout Demo")),
      drawer: Drawer(
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              children: <Widget>[
//                head,
                createHead(),
                ListTile(
                  title: Text("Help Me"),
                ),
                ListTile(
                  title: Text("About Us"),
                ),
                ListTile(
                  title: Text("Link"),
                )
              ],
            )),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 150,
          child: WaveView(
            parentWidgetSize: Size(150, 300),
          ),
        ),
      ),
    );
  }

  //自定义Head
  Widget createHead() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      /* padding置为0 */
      child: new Stack(children: <Widget>[
        /* 用stack来放背景图片 */
        new Image.asset(
          "assets/imag/bg.png",
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        new Align(
          /* 先放置对齐 */
          alignment: FractionalOffset.bottomLeft,//或者使用FractionalOffset(0.2, 0.6),  实际偏移量 (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
          child: Container(
            height: 70.0,
            margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              /* 宽度只用包住子组件即可 */
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: AssetImage("assets/imag/avater.png"),
                  radius: 35.0,
                ),
                new Container(
                  margin: EdgeInsets.only(left: 6.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                    mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                    children: <Widget>[
                      new Text(
                        "Linfc",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "1018596566@qq.com",
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
