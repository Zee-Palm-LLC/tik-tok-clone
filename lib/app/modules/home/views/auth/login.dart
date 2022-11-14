import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/views/auth/signup.dart';

import '../../../../data/constants/constants.dart';

import '../../widgets/buttons/custom_button.dart';
import '../../widgets/buttons/custom_text_button.dart';
import '../../widgets/textfields/custom_textformfield.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthController ac = Get.find<AuthController>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(flex: 1, child: Container()),
            SvgPicture.asset(CustomAssets.logo,
                color: CustomColors.primaryColor, height: 64.h),
            SizedBox(height: 64.h),
            TextFieldInput(
              textEditingController: _email,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Email';
                } else if (!val.isEmail) {
                  return 'Enter a Valid Email Address';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),
            TextFieldInput(
              textEditingController: _password,
              hintText: 'Password',
              isPass: true,
              textInputType: TextInputType.visiblePassword,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Email';
                }
                return null;
              },
            ),
            SizedBox(height: 34.h),
            CustomButton(
                color: CustomColors.redColor,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ac.loginUser(
                        email: _email.text.trim(),
                        password: _password.text.trim());
                    _email.clear();
                    _password.clear();
                  }
                },
                child: Text(
                  "Login",
                  style: CustomTextStyle.kMedium16,
                )),
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: CustomTextStyle.kMedium16),
                CustomTextButton(
                  onPressed: () {
                    Get.to(() => const SignUpScreen(),
                        duration: const Duration(milliseconds: 200));
                  },
                  text: "Sign Up",
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
