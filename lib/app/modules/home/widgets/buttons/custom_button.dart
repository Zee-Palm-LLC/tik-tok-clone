import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(Get.width, 50),
            primary: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r))),
        onPressed: onPressed,
        child: child);
  }
}
