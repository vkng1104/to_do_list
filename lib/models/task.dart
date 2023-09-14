import 'package:flutter/material.dart';

class Task {
  final String field;
  final String stage;
  final String course;
  DateTime startTime;
  DateTime endTime;
  final Color color;
  final IconData icon;
  int state;

  Task({
    required this.field,
    required this.stage,
    required this.course,
    required this.startTime,
    required this.endTime,
    this.color = Colors.blue,
    this.icon = Icons.check_circle_outline,
    required this.state,
  });
}