import 'package:flutter/material.dart';

import '../../../../data/constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: CustomTextStyle.kMedium16,
        ));
  }
}
