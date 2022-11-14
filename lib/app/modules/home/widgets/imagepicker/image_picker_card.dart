import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/constants/constants.dart';

class SelectImageWidget extends StatelessWidget {
  final VoidCallback? selectImageCallback;
  Widget child;
  SelectImageWidget({Key? key, this.selectImageCallback, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          child,
          CircleAvatar(
            radius: 22.r,
            backgroundColor: CustomColors.blueColor,
            child: Center(
              child: IconButton(
                  onPressed: selectImageCallback,
                  icon:
                      const Icon(Icons.add, color: CustomColors.primaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
