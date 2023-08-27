import 'package:flutter/material.dart';
import 'package:knob/knob.dart';

class KnobText extends KnobWidget<String> {
  final TextEditingController? controller;
  const KnobText({super.key, this.controller});

  @override
  Widget builder(context, controller) {
    final textController = this.controller ?? TextEditingController();

    textController.text = controller.value ?? '';
    return _KnobText(
      controller: textController,
      knob: controller,
    );
  }
}

class _KnobText extends StatefulWidget {
  final TextEditingController controller;
  final KnobController<String> knob;

  const _KnobText({required this.controller, required this.knob});

  @override
  State<_KnobText> createState() => _KnobTextState();
}

class _KnobTextState extends State<_KnobText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.knob.onChanged(
        delay: const Duration(milliseconds: 200),
      ),
    );
  }
}
