import 'package:flutter/widgets.dart';
import 'package:knob/src/knob_controller.dart';

class KnobScope<T> extends InheritedWidget {
  final KnobController<T> controller;

  const KnobScope({
    super.key,
    required this.controller,
    required Widget child,
  }) : super(child: child);

  static KnobScope<T> of<T>(BuildContext context) {
    final KnobScope<T>? result =
        context.dependOnInheritedWidgetOfExactType<KnobScope<T>>();
    assert(result != null, 'No KnobScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(KnobScope oldWidget) {
    return controller.value != oldWidget.controller.value;
  }
}
