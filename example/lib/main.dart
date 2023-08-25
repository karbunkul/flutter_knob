import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:knob/knob.dart';

import 'knob_text.dart';

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
            Knob<String>(
              initialData: 'Hello World',
              onChanged: _onChanged,
              child: const KnobText(),
            ),
            Knob<num>(
              initialData: 35,
              onChanged: _onChanged,
              child: const KnobSlider(),
            ),
            Knob<num>(
              initialData: 15,
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

class KnobSlider extends StatelessWidget {
  final double min;
  final double max;

  const KnobSlider({super.key, this.min = 0, this.max = 100});

  @override
  Widget build(context) {
    return KnobBuilder<num>(
      builder: (context, controller) {
        return Slider(
          value: controller.value?.toDouble() ?? min,
          min: min,
          max: max,
          onChanged: controller.onChanged(),
        );
      },
    );
  }
}
