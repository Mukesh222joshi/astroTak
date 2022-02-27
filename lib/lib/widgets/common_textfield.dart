import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// This is new common textfiled class used for text fields
class CustomTextFieldNew extends StatelessWidget {
  final String ?labelText;
  final TextEditingController ?controller;
  final bool obscureText;
  final Widget ?prefix;
  final Widget ?suffix;
  final String ?Function(String?) ?validator;
  final FocusNode ?focusNode;
  final TextInputAction ?textInputAction;
  final TextInputType ?keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) ?onFieldSubmitted;
  final int ?maxLength;
  final String ?hintText;
  final Function(String) ?onChanged;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final bool greyOutOnDisabled;
  final double height;
  final TextAlign textAlign;
  final VoidCallback ?onTap;
  final fillColor;
  final bool filled;

  CustomTextFieldNew({
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.suffix,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters = const [],
    this.onFieldSubmitted,
    this.maxLength,
    this.hintText,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.greyOutOnDisabled = false,
    this.prefix,
    this.height = 65,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.fillColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
        onTap: onTap,
        textAlign: textAlign,
        readOnly: readOnly,
        textCapitalization: textCapitalization,
        controller: controller,
        obscureText: obscureText,
        maxLength:maxLength,
        style:
            AppTheme.medium14Black,
        cursorColor: AppColors.black.withOpacity(0.2),
        validator: validator,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
            labelText: labelText??'',
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorMaxLines: 2,
            errorStyle: TextStyle(height: 0, color: Colors.transparent),
            hintStyle:
                AppTheme.medium14Black,
            labelStyle:AppTheme.normal14Black,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.black.withOpacity(0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: greyOutOnDisabled
                      ? Colors.transparent
                      : AppColors.black.withOpacity(0.2)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red),
            ),
            filled: (readOnly && greyOutOnDisabled) || filled,
            fillColor: fillColor ?? Theme.of(context).disabledColor,
            contentPadding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: prefix == null ? 8 : 0,
              right: suffix == null ? 8 : 0,
            ),
            prefixIcon: prefix,
            suffixIcon: suffix),
      ),
    );
  }
}
