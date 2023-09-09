import 'package:flutter/widgets.dart';
import 'package:knob/knob.dart';
import 'package:knob/src/knob_scope.dart';

abstract class KnobState<S extends StatefulWidget, T> extends State<S> {
  KnobController<T> get controller {
    return KnobScope.of<T>(context).controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initKnob();
    });
    super.initState();
  }

  @mustCallSuper
  void initKnob() {}
}
