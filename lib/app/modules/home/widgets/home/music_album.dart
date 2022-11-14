import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAnimation extends StatefulWidget {
  final String profilePic;
  const CircleAnimation({
    Key? key,
    required this.profilePic,
  }) : super(key: key);

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SizedBox(
        width: 60.w,
        height: 60.h,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(11.h),
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image(
                    image: NetworkImage(widget.profilePic),
                    fit: BoxFit.cover,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
