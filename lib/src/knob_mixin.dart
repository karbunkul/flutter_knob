import 'package:flutter/widgets.dart';

import 'knob_controller.dart';
import 'knob_scope.dart';

mixin KnobMixin<T, W extends StatefulWidget> on State<W> {
  KnobController<T> get controller => KnobScope.of<T>(context).controller;
}
