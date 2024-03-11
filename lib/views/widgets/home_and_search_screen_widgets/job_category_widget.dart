import 'package:flutter/material.dart';

class JobCategoryWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String category;
  const JobCategoryWidget({
    super.key,
    required this.category,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color.fromRGBO(214, 228, 255, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: textColor ?? const Color.fromRGBO(51, 102, 255, 1),
          ),
        ),
      ),
    );
  }
}
