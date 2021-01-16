import 'package:flutter/material.dart';

/// Clip widget in oval shape at right side
class OvalRightBorderClipper extends CustomClipper<Path> {
  OvalRightBorderClipper({
    @required this.curveHeight,
  });

  final double curveHeight;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - curveHeight, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - curveHeight, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
