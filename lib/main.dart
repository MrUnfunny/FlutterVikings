import 'package:flutter/material.dart';

const colors = {
  "lighterColor": Color(0xff07c6f9),
  "darkerColor": Color(0xff055799),
};

const logoSize = Size(750, 900);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: Center(
          child: AnimatedLogoView(),
        ),
      )),
    );
  }
}

class AnimatedLogoView extends StatefulWidget {
  @override
  _AnimatedLogoViewState createState() => _AnimatedLogoViewState();
}

class _AnimatedLogoViewState extends State<AnimatedLogoView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation firstPart, secondPart, thirdPart, fourthPart;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
    firstPart = CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.05, curve: Curves.easeIn),
    );

    secondPart = CurvedAnimation(
      parent: controller,
      curve: Interval(0.05, 0.1, curve: Curves.easeIn),
    );

    thirdPart = CurvedAnimation(
      parent: controller,
      curve: Interval(0.1, 0.3, curve: Curves.bounceInOut),
    );
    fourthPart = CurvedAnimation(
      parent: controller,
      curve: Interval(0.3, 0.4, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FittedBox(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Column(
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        painter: VikingsLogo(
                            firstPart.value, secondPart.value, thirdPart.value),
                        child: Container(
                          height: logoSize.height,
                          width: logoSize.width,
                        ),
                      ),
                      CustomPaint(
                        painter: HornsPainter(thirdPart.value),
                        child: Container(
                          height: logoSize.height,
                          width: logoSize.width,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text(
                    "Flutter Vikings",
                    style: TextStyle(
                        fontSize: 80,
                        color: colors['darkerColor']
                            .withOpacity(fourthPart.value)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VikingsLogo extends CustomPainter {
  final firstPartValue;
  final secondPartValue;
  final thirdPartValue;

  VikingsLogo(this.firstPartValue, this.secondPartValue, this.thirdPartValue);

  final darkerPaint = Paint()
    ..color = colors['darkerColor']
    ..style = PaintingStyle.fill;

  final lighterPaint = Paint()
    ..color = colors['lighterColor']
    ..style = PaintingStyle.fill;

  final drawLeftHelmet = Path()
    ..moveTo(392.09, 163.01)
    ..cubicTo(392.09, 163.01, 578.4, 349.33, 578.4, 349.33)
    ..cubicTo(578.4, 349.33, 63.64, 864.09, 63.64, 864.09)
    ..cubicTo(40.32, 887.41, 0.46, 870.89, 0.46, 837.92)
    ..cubicTo(0.46, 837.92, 0.46, 519.46, 0.46, 519.46)
    ..cubicTo(0.46, 509.64, 4.36, 500.23, 11.30, 493.29)
    ..cubicTo(11.30, 493.29, 341.58, 163.01, 341.58, 163.01)
    ..cubicTo(355.53, 149.07, 378.14, 149.07, 392.09, 163.01)
    ..cubicTo(392.09, 163.01, 392.09, 163.01, 392.09, 163.01);

  final drawRightHelmet = Path()
    ..moveTo(340.67, 163.93)
    ..cubicTo(340.67, 163.93, 155.27, 349.33, 155.27, 349.33)
    ..cubicTo(155.27, 349.33, 670.03, 864.09, 670.03, 864.09)
    ..cubicTo(693.35, 887.41, 733.21, 870.89, 733.21, 837.92)
    ..cubicTo(733.21, 837.92, 733.21, 519.46, 733.21, 519.46)
    ..cubicTo(733.21, 509.64, 729.31, 500.23, 722.37, 493.29)
    ..cubicTo(722.37, 493.29, 393.01, 163.93, 393.01, 163.93)
    ..cubicTo(378.55, 149.47, 355.12, 149.47, 340.67, 163.93)
    ..cubicTo(340.66, 163.93, 340.67, 163.93, 340.67, 163.93);

  final drawShadow = Path()
    ..moveTo(366.84, 560.89)
    ..cubicTo(366.84, 560.89, 155.27, 349.33, 155.27, 349.33)
    ..cubicTo(155.27, 349.33, 289.40, 638.33, 289.40, 638.33)
    ..cubicTo(289.40, 638.33, 366.84, 560.89, 366.84, 560.89);

  @override
  void paint(Canvas canvas, Size size) {
    final righthelmetMatrix =
        Matrix4.translationValues(1500 - 1500 * secondPartValue, 0, 0);
    final leftHelmetMatrix =
        Matrix4.translationValues(-1500 + 1500 * firstPartValue, 0, 0);

    canvas
      ..drawPath(
          drawLeftHelmet.transform(leftHelmetMatrix.storage), darkerPaint)
      ..drawPath(
          drawRightHelmet.transform(righthelmetMatrix.storage), lighterPaint)
      ..drawPath(
          drawShadow,
          Paint()
            ..shader = LinearGradient(colors: [
              Colors.black.withOpacity(0.3 * thirdPartValue),
              Colors.transparent,
            ]).createShader(drawShadow.getBounds()));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HornsPainter extends CustomPainter {
  final animationValue;

  final darkerPaint = Paint()
    ..color = colors['darkerColor']
    ..style = PaintingStyle.fill;

  final lighterPaint = Paint()
    ..color = colors['lighterColor']
    ..style = PaintingStyle.fill;

  final drawLeftHorn = Path()
    ..moveTo(129.66, 0.38)
    ..cubicTo(129.66, 0.38, 69.81, 179.43, 144.43, 244.04)
    ..cubicTo(144.43, 244.04, 57.93, 292.3, 36.08, 355.12)
    ..cubicTo(36.08, 355.12, -90.02, 185.61, 129.66, 0.38)
    ..cubicTo(129.66, 0.38, 129.66, 0.38, 129.66, 0.38);

  final drawRightHorn = Path()
    ..moveTo(603.91, 0.38)
    ..cubicTo(603.91, 0.38, 663.76, 179.43, 589.14, 244.04)
    ..cubicTo(589.14, 244.04, 675.64, 292.3, 697.49, 355.12)
    ..cubicTo(697.48, 355.12, 823.58, 185.61, 603.91, 0.38)
    ..cubicTo(603.91, 0.38, 603.91, 0.38, 603.91, 0.38);

  final drawLeftHolder = Path()
    ..moveTo(72.02, 420.26)
    ..cubicTo(72.02, 420.26, 20.42, 392.68, 45.40, 347.86)
    ..cubicTo(70.38, 303.04, 148.81, 240.61, 162.36, 245.81)
    ..cubicTo(175.91, 251.01, 217.26, 274.09, 217.26, 274.09)
    ..cubicTo(217.26, 274.09, 105.28, 344.19, 72.01, 420.26)
    ..cubicTo(72.01, 420.26, 72.02, 420.26, 72.02, 420.26);

  final drawRightHolder = Path()
    ..moveTo(661.55, 420.26)
    ..cubicTo(661.55, 420.26, 713.15, 392.68, 688.17, 347.86)
    ..cubicTo(663.19, 303.04, 584.76, 240.61, 571.21, 245.81)
    ..cubicTo(557.66, 251.01, 516.31, 274.09, 516.31, 274.09)
    ..cubicTo(516.31, 274.09, 628.29, 344.19, 661.55, 420.26)
    ..cubicTo(661.55, 420.26, 661.55, 420.26, 661.55, 420.26);

  HornsPainter(this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    final matrix =
        Matrix4.translationValues(0, -2000 + 2000 * animationValue, 0);

    canvas
      ..drawPath(drawLeftHorn.transform(matrix.storage),
          darkerPaint..color = colors['darkerColor'])
      ..drawPath(drawLeftHolder.transform(matrix.storage),
          darkerPaint..color = colors['darkerColor'])
      ..drawPath(drawRightHorn.transform(matrix.storage),
          lighterPaint..color = colors['lighterColor'])
      ..drawPath(drawRightHolder.transform(matrix.storage),
          lighterPaint..color = colors['lighterColor']);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
