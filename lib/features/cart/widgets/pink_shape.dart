import 'package:flutter/material.dart';

class PinkShape extends StatelessWidget {
  const PinkShape({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PinkSvgPainter(), size: Size.infinite);
  }
}

class PinkSvgPainter extends CustomPainter {
  final double originalWidth = 372;
  final double originalHeight = 723;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFFECEC)
          ..style = PaintingStyle.fill;

    final scaleX = size.width / originalWidth;
    final scaleY = size.height / originalHeight;

    final path = Path();

    path.moveTo(0 * scaleX, 17 * scaleY);
    path.quadraticBezierTo(0 * scaleX, 0 * scaleY, 17 * scaleX, 0 * scaleY);
    path.lineTo(355 * scaleX, 0 * scaleY);
    path.quadraticBezierTo(372 * scaleX, 0 * scaleY, 372 * scaleX, 17 * scaleY);
    path.lineTo(372 * scaleX, 682.467 * scaleY);

    path.cubicTo(
      372 * scaleX,
      698.858 * scaleY,
      351.09 * scaleX,
      705.756 * scaleY,
      341.337 * scaleX,
      692.583 * scaleY,
    );

    path.lineTo(339.163 * scaleX, 689.646 * scaleY);
    path.cubicTo(
      332.367 * scaleX,
      680.467 * scaleY,
      318.633 * scaleX,
      680.467 * scaleY,
      311.837 * scaleX,
      689.646 * scaleY,
    );

    path.lineTo(292.663 * scaleX, 715.545 * scaleY);
    path.cubicTo(
      285.867 * scaleX,
      724.724 * scaleY,
      272.133 * scaleX,
      724.724 * scaleY,
      265.337 * scaleX,
      715.545 * scaleY,
    );

    path.lineTo(246.163 * scaleX, 689.646 * scaleY);
    path.cubicTo(
      239.367 * scaleX,
      680.467 * scaleY,
      225.633 * scaleX,
      680.467 * scaleY,
      218.837 * scaleX,
      689.646 * scaleY,
    );

    path.lineTo(199.663 * scaleX, 715.545 * scaleY);
    path.cubicTo(
      192.867 * scaleX,
      724.724 * scaleY,
      179.133 * scaleX,
      724.724 * scaleY,
      172.337 * scaleX,
      715.545 * scaleY,
    );

    path.lineTo(153.163 * scaleX, 689.646 * scaleY);
    path.cubicTo(
      146.367 * scaleX,
      680.467 * scaleY,
      132.633 * scaleX,
      680.467 * scaleY,
      125.837 * scaleX,
      689.646 * scaleY,
    );

    path.lineTo(106.663 * scaleX, 715.545 * scaleY);
    path.cubicTo(
      99.8671 * scaleX,
      724.724 * scaleY,
      86.1329 * scaleX,
      724.724 * scaleY,
      79.3369 * scaleX,
      715.545 * scaleY,
    );

    path.lineTo(60.1631 * scaleX, 689.646 * scaleY);
    path.cubicTo(
      53.3671 * scaleX,
      680.467 * scaleY,
      39.6329 * scaleX,
      680.467 * scaleY,
      32.8369 * scaleX,
      689.646 * scaleY,
    );

    path.lineTo(30.6631 * scaleX, 692.583 * scaleY);
    path.cubicTo(
      20.9103 * scaleX,
      705.756 * scaleY,
      0 * scaleX,
      698.858 * scaleY,
      0 * scaleX,
      682.467 * scaleY,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
