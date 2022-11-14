import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/constants.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/widgets/textfields/custom_textformfield.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../controllers/video_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  UploadVideoController uc = Get.find<UploadVideoController>();
  AuthController ac = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    uc.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(child: Obx(() {
                return ListView.builder(
                    itemCount: uc.commentList.length,
                    itemBuilder: (context, index) {
                      var data = uc.commentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(data.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              data.username,
                              style: CustomTextStyle.kBold18
                                  .copyWith(color: CustomColors.redColor),
                            ),
                            SizedBox(width: 4.w),
                            Text(data.comment, style: CustomTextStyle.kBold18),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            // Text(tago.format(data.datePublished),
                            //     style: CustomTextStyle.kMedium12),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${data.likes.length} likes',
                                style: CustomTextStyle.kMedium12)
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () async {
                            await uc.likeComment(data.id);
                          },
                          child: Icon(Icons.favorite,
                              size: 25.h,
                              color: data.likes.contains(ac.user!.uid)
                                  ? Colors.red
                                  : Colors.white),
                        ),
                      );
                    });
              })),
              const Divider(),
              ListTile(
                title: Form(
                  key: _formKey,
                  child: TextFieldInput(
                    hintText: 'Enter Comment',
                    textInputType: TextInputType.text,
                    isPass: false,
                    textEditingController: _commentController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter a comment';
                      }
                      return null;
                    },
                  ),
                ),
                trailing: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await uc.postComments(comments: _commentController.text);
                    }
                    _commentController.clear();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
