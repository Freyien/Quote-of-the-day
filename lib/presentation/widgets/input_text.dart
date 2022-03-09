import 'package:flutter/material.dart';
import 'package:phrase_of_the_day/presentation/utils/app_colors.dart';

class InputText extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  const InputText({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 12, 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: false,
        filled: true,
        fillColor: AppColors.input,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.input),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.input),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.input),
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
