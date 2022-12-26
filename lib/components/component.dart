// ignore_for_file: invalid_required_named_param

import 'package:flutter/material.dart';

String? uid;

Widget myTextFormField({
  @required controller,
  @required String? Function(String?)? validator,
  @required Function(dynamic value)? onFieldSubmitted,
  @required String? label,
  @required prefixIcon,
  @required suffixIcon,
  @required TextInputType? keyboardType,
  @required bool obscureText = false,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        label: Text("${label}"),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
