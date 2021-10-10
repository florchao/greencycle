import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  Input(
      {required this.placeholder,
      required this.suffixIcon,
        required this.onTap,
        required this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.verdeOscuro,
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: ArgonColors.black,
        controller: controller,
        autofocus: autofocus,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.verdeOscuro),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(
              color: ArgonColors.azul,
            ),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
