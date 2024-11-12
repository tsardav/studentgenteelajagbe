import 'package:student/utils/utils.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.onPressed,
    required this.colors,
    this.height,
    this.width,
    required this.text,
    this.gradientDirection,
  });

  final Function onPressed;
  final List<Color> colors;
  final double? height;
  final double? width;
  final String text;
  final GradientDirection? gradientDirection;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: GradientButton(
        colors: colors,
        height: height ?? 50,
        width: width ?? double.infinity,
        radius: 8.r,
        gradientDirection: gradientDirection ?? GradientDirection.topToBottom,
        textStyle: Styles.x16dp_2FC67E_500w(color: Colors.white),
        text: text,
        onPressed: () => onPressed(),
      ),
    );
  }
}
