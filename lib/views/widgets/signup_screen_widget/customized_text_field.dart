import 'package:flutter/material.dart';

class CustomizedTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? helperText;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  const CustomizedTextFormField({
    super.key,
    this.controller,
    this.obscureText,
    this.autofocus,
    this.validator,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.helperText,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.hintText = '',
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      autofocus: autofocus ?? false,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(17, 24, 39, 1),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        labelText: labelText,
        helperText: helperText,
        hintText: hintText,
        helperStyle: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(156, 163, 175, 1),
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(255, 71, 43, 1),
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromRGBO(209, 213, 219, 1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromRGBO(51, 102, 255, 1),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromRGBO(156, 163, 175, 1),
            width: 1,
          ),
        ),
      ),
    );
  }
}
