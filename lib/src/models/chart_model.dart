import 'package:flutter/material.dart';

class ChartData {
  ChartData({
    required this.type,
    required this.total,
    required this.color,
  });

  final String type;
  final double total;
  final Color color;
}
