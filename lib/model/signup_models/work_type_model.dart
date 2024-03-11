import 'package:flutter/material.dart';

class WorkTypeModel {
  final IconData icon;
  final String text;
  bool selected;
  WorkTypeModel({
    required this.icon,
    required this.text,
    this.selected = false,
  });
}
