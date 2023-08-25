import 'package:flutter/cupertino.dart';

abstract interface class KnobController<T> {
  T? get value;
  ValueChanged<T?> onChanged({Duration? delay});
  void dispose();
}
