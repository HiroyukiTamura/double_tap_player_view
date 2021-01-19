import 'package:flutter/material.dart';

/// Clip widget in oval shape at right side
class OvalLeftBorderClipper extends CustomClipper<Path> {
  OvalLeftBorderClipper({
    @required this.curveHeight,
  });

  final double curveHeight;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(curveHeight, 0);
    path.quadraticBezierTo(0, size.height / 4, 0, size.height / 2);
    path.quadraticBezierTo(
        0, size.height - (size.height / 4), curveHeight, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
