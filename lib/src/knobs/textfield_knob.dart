part of 'knobs.dart';

class TextfieldKnob extends StatefulWidget {
  final TextEditingController? controller;
  final bool autofocus;

  const TextfieldKnob({
    super.key,
    this.controller,
    this.autofocus = false,
  });

  @override
  State<TextfieldKnob> createState() => _TextfieldKnobState();
}

class _TextfieldKnobState extends KnobState<TextfieldKnob, String> {
  late final _controller = widget.controller ?? TextEditingController();

  @override
  void initKnob() {
    super.initKnob();
    _controller.text = controller.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus,
      onChanged: controller.onChanged(
        delay: const Duration(milliseconds: 200),
      ),
      controller: _controller,
    );
  }
}
