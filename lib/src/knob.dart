import 'dart:async';

import 'package:debounce_builder/debounce_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:knob/knob.dart';
import 'package:knob/src/knob_scope.dart';

class Knob<T> extends StatefulWidget {
  final Widget child;
  final ValueChanged<T?> onChanged;
  final T? initialData;

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
  final _value = StreamController<T?>.broadcast();

  @override
  void initState() {
    _controller = _Controller<T>(
      value: widget.initialData,
      onChanged: _onChanged,
    );
    super.initState();

    if (widget.initialData != null) {
      widget.onChanged(widget.initialData);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (T == dynamic) {
      throw Exception('Knob<dynamic> is bad idea, please use generic type');
    }

    return StreamBuilder<T?>(
      stream: _value.stream,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (_controller.value != snapshot.data) {
          _controller = _controller.fromValue(snapshot.data);
        }

        return KnobScope<T>(
          controller: _controller,
          child: widget.child,
        );
      },
    );
  }

  void _onChanged(T? value) {
    Future.delayed(Duration.zero, () {
      _value.add(value);
      widget.onChanged(value);
    });
  }

  @override
  void didUpdateWidget(covariant Knob<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialData != oldWidget.initialData) {
      _onChanged(widget.initialData);
    }
  }

  @override
  void dispose() {
    _value.close();
    _controller.dispose();
    super.dispose();
  }
}

final class _Controller<T> implements KnobController<T> {
  final T? _value;
  final ValueChanged<T?> _onChanged;
  DebounceTimer? _timer;

  _Controller({
    required ValueChanged<T?> onChanged,
    T? value,
  })  : _value = value,
        _onChanged = onChanged;

  _Controller<T> fromValue(T? value) {
    return _Controller<T>(onChanged: _onChanged, value: value);
  }

  @override
  T? get value => _value;

  @override
  ValueChanged<T?> onChanged({Duration? delay}) {
    if (delay == null) {
      return _onChanged;
    }

    _timer ??= DebounceTimer(delay: delay);

    if (delay != _timer!.delay) {
      _timer!.dispose();
      _timer = DebounceTimer(delay: delay);
    }

    return (T? value) {
      _timer!.debounce(() => _onChanged(value));
    };
  }

  @override
  void dispose() {
    _timer?.dispose();
  }
}
