import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';

class MyColorizeAnimatedText extends AnimatedText {
  MyColorizeAnimatedText(
    String text, {
    super.textAlign,
    required TextStyle super.textStyle,
    this.speed = const Duration(milliseconds: 200),
    required this.colors,
    this.textDirection = TextDirection.ltr,
  })  : assert(null != textStyle.fontSize),
        assert(colors.length > 1),
        super(
          text: text,
          duration: speed * text.characters.length,
        );

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 200 milliseconds.
  final Duration speed;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  final List<Color> colors;

  /// Specifies the [TextDirection] for animation direction.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  late Animation<double> _colorShifter, _fadeIn, _fadeOut;

  // Copy of colors that may be reversed when RTL.
  late List<Color> _colors;

  bool isReverse = false;

  @override
  void initAnimation(AnimationController controller) {
    // Note: This calculation is the only reason why [textStyle] is required
    final tuning = (35 * colors.length) *
        (textStyle!.fontSize! / 24.0) *
        0.75 *
        (textCharacters.length / 15.0);

    final colorShift = colors.length * tuning;
    final colorTween = !isReverse
        ? Tween<double>(
            begin: 0.0,
            end: colorShift,
          )
        : Tween<double>(
            begin: colorShift,
            end: 0.0,
          );
    _colorShifter = colorTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    // With RTL, colors need to be reversed to compensate for colorTween
    // counting down instead of up.
    _colors = textDirection == TextDirection.ltr
        ? colors
        : colors.reversed.toList(growable: false);

    isReverse = !isReverse;
  }


  @override
  Widget completeText(BuildContext context) {
    final linearGradient = LinearGradient(colors: _colors).createShader(
      Rect.fromLTWH(0.0, 0.0, _colorShifter.value , 0.0),
    );

    return DefaultTextStyle.merge(
      style: textStyle,
      child: Text(
        text,
        style: TextStyle(foreground: Paint()..shader = linearGradient),
        textAlign: textAlign,
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return completeText(context);
  }
}
