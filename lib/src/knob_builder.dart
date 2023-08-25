import 'package:flutter/widgets.dart';
import 'package:knob/knob.dart';
import 'package:knob/src/knob_scope.dart';

typedef KnobWidgetBuilder<T> = Widget Function(
  BuildContext context,
  KnobController<T> controller,
);

class KnobBuilder<T> extends StatelessWidget {
  final KnobWidgetBuilder<T> builder;
  const KnobBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, KnobScope.of<T>(context).controller);
  }
}
