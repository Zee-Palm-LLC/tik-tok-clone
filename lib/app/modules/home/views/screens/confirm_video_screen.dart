import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/services/firebase_storage.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/constants/constants.dart';
import '../../controllers/video_controller.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/textfields/custom_textformfield.dart';

class ConfirmVideoScreen extends StatefulWidget {
  File video;
  String videoPath;
  ConfirmVideoScreen({Key? key, required this.video, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  final _captionController = TextEditingController();
  final _songController = TextEditingController();
  late VideoPlayerController videoPlayerController;
  UploadVideoController uv = Get.find<UploadVideoController>();
  @override
  void initState() {
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.video);
      videoPlayerController.initialize();
      videoPlayerController.play();
      videoPlayerController.pause();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            SizedBox(
              width: Get.width,
              height: Get.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFieldInput(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Caption';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  isPass: false,
                  textEditingController: _captionController,
                  hintText: 'Enter Caption'),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFieldInput(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Song Name';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  isPass: false,
                  textEditingController: _songController,
                  hintText: 'Enter Song Name'),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                onPressed: () async {
                  await uv.uploadVideo(_songController.text,
                      _captionController.text, widget.videoPath);
                },
                color: CustomColors.primaryColor,
                child: Text(
                  'Share',
                  style: CustomTextStyle.kBold18
                      .copyWith(color: CustomColors.mobileBackgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
