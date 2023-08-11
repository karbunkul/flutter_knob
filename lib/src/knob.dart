import 'package:flutter/widgets.dart';
import 'package:knob/knob.dart';
import 'package:knob/src/knob_scope.dart';

class Knob<T> extends StatefulWidget {
  final T? initialData;
  final KnobField<T> child;
  final ValueChanged<T?> onChanged;

  const Knob({
    super.key,
    required this.onChanged,
    required this.child,
    this.initialData,
  });

  @override
  State<Knob<T>> createState() => _KnobState<T>();
}

class _KnobState<T> extends State<Knob<T>> {
  late _Controller<T> _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallback);
    super.initState();
    _controller = _Controller<T>(
      notifier: _KnobNotifier(),
      value: widget.initialData,
      onChanged: _onChanged,
    );

    if (widget.initialData != null) {
      _onChanged(widget.initialData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KnobScope<T>(
      controller: _controller,
      child: widget.child,
    );
  }

  void _onChanged(T? value) {
    if (_controller.value != value || _controller.value == widget.initialData) {
      widget.onChanged(value);
      if (mounted) {
        setState(() {
          _controller = _controller.fromValue(value);
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant Knob<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialData != oldWidget.initialData) {
      _onChanged(widget.initialData);
      WidgetsBinding.instance.addPostFrameCallback(_postFrameCallback);
    }
  }

  void _postFrameCallback(Duration timeStamp) {
    _controller.notifier.notify();
  }
}

final class _Controller<T> extends KnobController<T> {
  final _KnobNotifier notifier;
  _Controller({
    required super.value,
    required this.notifier,
    required super.onChanged,
  }) : super(
          addListener: notifier.addListener,
          removeListener: notifier.removeListener,
        );

  _Controller<T> fromValue(T? value) {
    return _Controller(value: value, onChanged: onChanged, notifier: notifier);
  }
}

final class _KnobNotifier with ChangeNotifier {
  void notify() => notifyListeners();
}
