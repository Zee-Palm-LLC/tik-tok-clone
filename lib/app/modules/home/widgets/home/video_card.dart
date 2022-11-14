// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:tik_tok/app/data/constants/colors.dart';

class VideoCard extends StatefulWidget {
  final String videoUrl;
  const VideoCard({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController controller;
  @override
  void initState() {
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        controller.setVolume(1);
        controller.play();
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        color: CustomColors.mobileBackgroundColor,
      ),
      child: InkWell(child: VideoPlayer(controller)),
    );
  }
}
