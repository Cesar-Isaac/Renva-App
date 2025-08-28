import 'package:flutter/material.dart';

import '../../../../core/style/repo.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget svgIcon;
  final String? Function(String?)? validator;
  final String hintText;
  final bool? readOnly;
  final Function()? onTap;

  const FormTextField({
    super.key,
    required this.controller,
    required this.svgIcon,
    required this.validator,
    required this.hintText,
    this.onTap,
    this.keyboardType,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: StyleRepo.red,
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: StyleRepo.red, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: StyleRepo.red),
          borderRadius: BorderRadius.circular(24),
        ),
        hintText: hintText,
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              svgIcon,
              const SizedBox(width: 8),
              Container(width: 1, height: 24, color: StyleRepo.grey),
            ],
          ),
        ),
      ),
      validator: validator,
    );
  }
}
