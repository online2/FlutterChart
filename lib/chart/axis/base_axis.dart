import 'package:flutter/material.dart';

class BaseAxis {
  BaseAxis(
      {this.mEnable,
      this.mTextSize,
      this.mTextColor,
      this.mXOffset,
      this.mYOffset,
      this.mGridColor,
      this.mGridLineWidth,
      this.mDrawGridLines,
      this.mAxisLineColor,
      this.mAxisLineHeight,
      this.mDrawAxisLine,
      this.mEntries});

  bool mEnable = true;

  //文字大小
  double mTextSize = 10;
  Color mTextColor = Colors.black;

  double mXOffset = 5;
  double mYOffset = 5;

  Color mGridColor = Colors.black;
  double mGridLineWidth = 1;
  bool mDrawGridLines = true;

  Color mAxisLineColor = Colors.black;
  double mAxisLineHeight = 1;
  bool mDrawAxisLine = true;

  List<String> mEntries = List();
}

class XAxis extends BaseAxis {
  XAxisPosition mPosition = XAxisPosition.TOP;

  XAxis({this.mPosition});
}

class YAxis extends BaseAxis {
  YAxisLabelPosition mPosition = YAxisLabelPosition.OUTSIDE_CHART;

  YAxis({this.mPosition});
}

enum XAxisPosition { TOP, BOTTOM, BOTH_SIDED, TOP_INSIDE, BOTTOM_INSIDE }

enum YAxisLabelPosition { OUTSIDE_CHART, INSIDE_CHART }



