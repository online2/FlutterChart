import 'package:flutter/material.dart';

class TouchEventNotifier extends ValueNotifier<TouchEvent>{
  TouchEventNotifier(TouchEvent value) : super(value);

}
abstract class TouchEvent{
  Offset getOffset();
}

class ChartPressDown extends TouchEvent{
  final Offset localPosition;

  ChartPressDown(this.localPosition);

  @override
  Offset getOffset() {
    return localPosition;
  }

}

class ChartPressMove extends TouchEvent {

  final Offset localPosition;

  ChartPressMove(this.localPosition);

  @override
  Offset getOffset() {
    return localPosition;
  }

}

class ChartPressUp extends TouchEvent {

  final Offset localPosition;

  ChartPressUp(this.localPosition);

  @override
  Offset getOffset() {
    return localPosition;
  }

}