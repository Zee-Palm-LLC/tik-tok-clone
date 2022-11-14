import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/constants.dart';
import 'package:tik_tok/app/modules/home/views/auth/login.dart';
import 'package:tik_tok/app/modules/home/views/auth/signup.dart';
import 'package:tik_tok/app/modules/home/widgets/buttons/custom_button.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CustomAssets.kStarter),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight + 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: CustomTextStyle.kBold25,
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.all(12.h),
                        child: Text(
                          "Create a profile, follow other accounts, make your own videos, and more.",
                          style: CustomTextStyle.kBold18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                      color: CustomColors.redColor,
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: CustomTextStyle.kBold18,
                      )),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                      color: CustomColors.primaryColor,
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: Text(
                        "Sign up",
                        style: CustomTextStyle.kBold18
                            .copyWith(color: Colors.black),
                      )),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
