import 'dart:math';
import 'dart:ui';

List<Offset> calculatePoints(int n) {
  List<Offset> points = [];
  double centerX = 0;
  double centerY = 0;
  double radius = 1;

  for (int i = 0; i < n; i++) {
    double angle = 2 * pi * i / n;
    double x = centerX + radius * cos(angle);
    double y = centerY + radius * sin(angle);
    points.add(Offset(x, y));
  }

  return points;
}