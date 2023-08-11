import 'package:flutter/widgets.dart';
import 'package:knob/src/knob_controller.dart';
import 'package:knob/src/knob_scope.dart';

abstract base class KnobField<T> extends StatelessWidget {
  const KnobField({super.key});

  Widget builder(BuildContext context, KnobController<T> controller);

  @override
  Widget build(BuildContext context) {
    final scope = KnobScope.of<T>(context);
    return builder(context, scope.controller);
  }
}
