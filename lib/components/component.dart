// ignore_for_file: invalid_required_named_param

import 'package:flutter/material.dart';

String? uid;
// String? postId;

Widget myTextFormField({
  @required controller,
  @required String? Function(String?)? validator,
  @required Function(dynamic value)? onFieldSubmitted,
  Widget? label,
  @required String? hintText,
  @required prefixIcon,
  @required suffixIcon,
  @required TextInputType? keyboardType,
  @required bool obscureText = false,
  // @required int? maxLines,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      // maxLines: maxLines,
      decoration: InputDecoration(
        label: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
