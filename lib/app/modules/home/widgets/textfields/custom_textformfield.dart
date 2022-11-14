import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/constants/constants.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  const TextFieldInput({
    Key? key,
    this.validator,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validator,
      style: CustomTextStyle.kMedium14,
      decoration: InputDecoration(
        errorStyle:
            CustomTextStyle.kMedium14.copyWith(color: CustomColors.redColor),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                icon: show
                    ? Icon(
                        Icons.visibility_off,
                        color: CustomColors.primaryColor,
                        size: 26.sp,
                      )
                    : Icon(Icons.visibility,
                        color: CustomColors.primaryColor, size: 26.sp))
            : const SizedBox(),
        hintText: widget.hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass ? show : false,
    );
  }
}
