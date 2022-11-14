// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileIcon extends StatelessWidget {
  String profilePic;
  ProfileIcon({
    Key? key,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50.w,
            height: 50.h,
            padding: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image(
                image: NetworkImage(profilePic),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
