import 'package:flutter/material.dart';

class Task {
  int? id;
  String title;
  String note;
  int isCompleted;
  DateTime startTime;
  DateTime endTime;
  Color color;
  int remind;
  String repeat;

  Task({this.id,
    required this.title,
    required this.note,
    this.isCompleted = 0,
    required this.startTime,
    required this.endTime,
    this.color = Colors.blue,
    this.remind = 5,
    this.repeat = "None"
  });

  Task fromJson(Map<String, dynamic> json) => Task(
    id : json['id'],
    title : json['title'],
    note : json['note'],
    isCompleted : json['isCompleted'],
    startTime : json['startTime'],
    endTime : json['endTime'],
    color : json['color'],
    remind : json['remind'],
    repeat : json['repeat'],
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title ' : title,
    'note ' : note,
    'isCompleted ' : isCompleted,
    'startTime ' : endTime,
    'endTime ' : endTime,
    'color ' : color,
    'remind ' : remind,
    'repeat ' : repeat,
  };
}