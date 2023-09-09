part of 'knobs.dart';

class SliderKnob extends KnobWidget<num> {
  final double min;
  final double max;

  const SliderKnob({super.key, this.min = 0, this.max = 100});

  @override
  Widget builder(context, controller) {
    return Slider(
      value: controller.value?.toDouble() ?? min,
      min: min,
      max: max,
      onChanged: controller.onChanged(),
    );
  }
}
