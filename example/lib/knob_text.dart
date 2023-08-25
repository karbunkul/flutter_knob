import 'package:flutter/material.dart';
import 'package:knob/knob.dart';

class KnobText extends StatefulWidget {
  final TextEditingController? controller;

  const KnobText({super.key, this.controller});

  @override
  State<KnobText> createState() => _KnobTextState();
}

class _KnobTextState extends State<KnobText> with KnobMixin<String, KnobText> {
  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller ??=
        widget.controller ?? TextEditingController(text: controller.value);

    if (_controller!.text != controller.value) {
      _controller!.text = controller.value ?? '';
    }

    return TextField(
      controller: _controller,
      onChanged: controller.onChanged(
        delay: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant KnobText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller;
      controller.onChanged()(widget.controller?.text);
    }
  }
}
