import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:knob/knob.dart';

void main() => runApp(const MyApp());

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
              child: const TextfieldKnob(),
            ),
            Knob<num>(
              initialData: 35,
              onChanged: _onChanged,
              child: const SliderKnob(),
            ),
            Knob<num>(
              initialData: 15,
              onChanged: _onChanged,
              child: const SliderKnob(),
            ),
          ],
        ),
      ),
    );
  }

  void _onChanged(value) => log('onChanged $value');
}
