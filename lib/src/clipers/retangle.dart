import 'package:flutter/material.dart';

class RetangleCustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.width);
    //path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}