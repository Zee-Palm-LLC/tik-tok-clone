import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/constants.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/controllers/video_controller.dart';
import 'package:tik_tok/app/modules/home/views/screens/comment_screen.dart';
import 'package:tik_tok/app/modules/home/widgets/home/music_album.dart';
import 'package:tik_tok/app/modules/home/widgets/home/profile_icon.dart';
import 'package:tik_tok/app/modules/home/widgets/home/video_card.dart';

class VideoScreen extends StatelessWidget {
  UploadVideoController uc = Get.find<UploadVideoController>();
  AuthController ac = Get.find<AuthController>();
  VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: uc.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  VideoCard(videoUrl: uc.videoList[index].videoUrl),
                  Column(
                    children: [
                      SizedBox(height: 100.h),
                      Expanded(
                          child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(uc.videoList[index].username,
                                    style: CustomTextStyle.kBold18),
                                SizedBox(height: 5.h),
                                Text(uc.videoList[index].caption,
                                    style: CustomTextStyle.kMedium16),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    const Icon(Icons.music_note),
                                    SizedBox(width: 3.h),
                                    Text(uc.videoList[index].songName,
                                        style: CustomTextStyle.kMedium16),
                                  ],
                                )
                              ],
                            ),
                          )),
                          Container(
                              width: 100.w,
                              margin: EdgeInsets.only(top: Get.height / 5),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ProfileIcon(
                                        profilePic:
                                            uc.videoList[index].profilePhoto),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await uc.likeVideo(
                                                id: uc.videoList[index].id);
                                          },
                                          child: Icon(Icons.favorite,
                                              size: 40.h,
                                              color: uc.videoList[index].likes
                                                      .contains(ac.firebaseAuth
                                                          .currentUser!.uid)
                                                  ? CustomColors.redColor
                                                  : CustomColors.primaryColor),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                            uc.videoList[index].likes.length
                                                .toString(),
                                            style: CustomTextStyle.kBold18),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => CommentScreen(
                                                id: uc.videoList[index].id));
                                          },
                                          child: Icon(
                                            Icons.comment,
                                            size: 40.h,
                                            color: CustomColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                            uc.videoList[index].commentCount
                                                .toString(),
                                            style: CustomTextStyle.kBold18)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.reply,
                                            size: 40.h,
                                            color: CustomColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          uc.videoList[index].shareCount
                                              .toString(),
                                          style: CustomTextStyle.kBold18,
                                        )
                                      ],
                                    ),
                                    CircleAnimation(
                                        profilePic:
                                            uc.videoList[index].profilePhoto)
                                  ]))
                        ],
                      ))
                    ],
                  )
                ],
              );
            });
      }),
    );
  }
}
