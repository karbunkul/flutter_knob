import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:knob/knob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Knob Demo')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Knob(
              initialData: 'Hello World',
              onChanged: _onChanged,
              delay: const Duration(milliseconds: 300),
              child: KnobText(controller: TextEditingController()),
            ),
            Knob(
              initialData: 15,
              delay: const Duration(milliseconds: 20),
              onChanged: _onChanged,
              child: const KnobSlider(),
            ),
          ],
        ),
      ),
    );
  }

  void _onChanged(value) => log('onChanged $value');
}

final class KnobText extends KnobField<String> {
  final TextEditingController? controller;

  const KnobText({super.key, this.controller});

  @override
  Widget builder(context, controller) {
    return _KnobText(textController: this.controller, controller: controller);
  }
}

class _KnobText extends StatefulWidget {
  final TextEditingController? textController;
  final KnobController<String> controller;

  const _KnobText({
    required this.controller,
    required this.textController,
  });

  @override
  State<_KnobText> createState() => _KnobTextState();
}

class _KnobTextState extends State<_KnobText> {
  late final TextEditingController _textController;

  void _listener() {
    final newValue = widget.controller.value ?? '';

    if (_textController.text != newValue) {
      log('Text updated ${widget.controller.value}');
      _textController.text = newValue;
    }
  }

  @override
  void initState() {
    widget.controller.addListener(_listener);
    _textController = widget.textController ?? TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.key,
      controller: _textController,
      onChanged: widget.controller.onChanged,
    );
  }
}

final class KnobSlider extends KnobField<num> {
  final double min;
  final double max;

  const KnobSlider({super.key, this.min = 0, this.max = 100});

  @override
  Widget builder(context, controller) {
    return Slider(
      value: controller.value?.toDouble() ?? min,
      min: min,
      max: max,
      onChanged: controller.onChanged,
    );
  }
}
