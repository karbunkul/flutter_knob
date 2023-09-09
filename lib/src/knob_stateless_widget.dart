import 'package:flutter/widgets.dart';
import 'package:knob/knob.dart';
import 'package:knob/src/knob_scope.dart';

abstract class KnobWidget<T> extends StatelessWidget {
  const KnobWidget({super.key});

  Widget builder(BuildContext context, KnobController<T> controller);

  @override
  Widget build(BuildContext context) {
    return builder(context, KnobScope.of<T>(context).controller);
  }
}
