import 'package:flutter/material.dart';

class SuggestHeadlineJob extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const SuggestHeadlineJob(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Color.fromRGBO(17, 24, 39, 1),
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        onPressed == null
            ? const SizedBox()
            : TextButton(
                onPressed: onPressed,
                child: const Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromRGBO(51, 102, 255, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
      ],
    );
  }
}
