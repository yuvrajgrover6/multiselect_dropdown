import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final englishNumbersAndSymbolsOnlyFormatters =
    FilteringTextInputFormatter.allow(
        RegExp("[a-zA-Z0-9\\s-#,/~`'!@\$%^&*()_+={}|;<>.?:\"\\[\\]\\\\]"));
final englishOnlyFormatters =
    FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"));
final englishAndNumberOnlyFormatters =
    FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]"));

class PrimaryTextField extends StatelessWidget {
  final double width;
  final String title;
  final bool? hideTitle;
  final String hint;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final bool isDisabled;
  final bool showSuffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isObscure;
  final bool? isFilled;
  final String? initialValue;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextStyle? style;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextInputFormatter? inputFormatter;
  final Color? primaryColor;
  final InputDecoration? decoration;
  const PrimaryTextField({
    Key? key,
    required this.width,
    required this.title,
    this.hideTitle,
    this.isObscure = false,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.isDisabled = false,
    required this.showSuffixIcon,
    this.validator,
    required this.controller,
    this.isFilled,
    this.keyboardType,
    this.maxLines = 1,
    this.initialValue,
    this.style,
    this.onChanged,
    this.focusNode,
    this.maxLength,
    this.inputFormatter,
    this.primaryColor,
    this.decoration,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final primaryColor = this.primaryColor ?? Theme.of(context).primaryColor;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: width * 0.85,
              child: TextFormField(
                  inputFormatters: inputFormatter == null
                      ? [englishNumbersAndSymbolsOnlyFormatters]
                      : [inputFormatter!],
                  maxLength: maxLength,
                  focusNode: focusNode,
                  autofocus: false,
                  onChanged: onChanged,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller,
                  initialValue: initialValue,
                  validator: validator,
                  readOnly: isDisabled,
                  onTap: onTap,
                  obscureText: isObscure,
                  keyboardType: keyboardType,
                  maxLines: isObscure ? 1 : maxLines,
                  style: style,
                  decoration: decoration ??
                      InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          filled: true,
                          fillColor: primaryColor,
                          prefixIcon: prefixIcon,
                          suffixIcon: showSuffixIcon
                              ? GestureDetector(
                                  onTap: onTap, child: Icon(suffixIcon))
                              : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(16)),
                          hintText: hint,
                          floatingLabelStyle: TextStyle(
                              fontSize: width * 0.035, color: Colors.black),
                          labelText: hideTitle == true ? null : title,
                          labelStyle: TextStyle(
                              fontSize: width * 0.035, color: primaryColor),
                          hintStyle: TextStyle(
                              fontSize: width * 0.035,
                              color: const Color(0xffAAAAAA)))))
        ],
      ),
    );
  }
}
