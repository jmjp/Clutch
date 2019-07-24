import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

class CircleProgressBar extends StatefulWidget{
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  const CircleProgressBar({
    Key key,
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  _CircleProgressBar createState() => _CircleProgressBar();

}


class _CircleProgressBar extends State<CircleProgressBar> with SingleTickerProviderStateMixin{
  AnimationController progressAnimationControler;
  Animation<double> progressAnimation;


  @override
  void initState() { 
    super.initState();
    progressAnimationControler = AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    progressAnimation = Tween<double>(begin: 0,end: widget.value).animate(progressAnimationControler)..addListener((){
      setState(() {
        
      });
    });
    progressAnimationControler.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        child: Container(
          child: Center(child: Text("${widget.value.toStringAsFixed(2)}%")),
        ),
        foregroundPainter: CircleProgressBarPainter(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          percentage: progressAnimation.value,
        ),
      ),
    );
  }
}

// Draws the progress bar.
class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize = size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide = Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (this.percentage ?? 0));

    // Don't draw the background if we don't have a background color
    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}