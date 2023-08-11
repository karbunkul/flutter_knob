import 'package:flutter/cupertino.dart';

base class KnobController<T> {
  final T? value;
  final ValueChanged<T?> onChanged;
  final ValueChanged<VoidCallback> addListener;
  final ValueChanged<VoidCallback> removeListener;

  const KnobController({
    required this.value,
    required this.onChanged,
    required this.addListener,
    required this.removeListener,
  });
}
