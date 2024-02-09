import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class PickImageBottomSheet extends StatelessWidget {
  VoidCallback onCameraPressed, onGalleryPressed, onDeletePressed;
  PickImageBottomSheet({
    super.key,
    required this.onCameraPressed,
    required this.onGalleryPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: onCameraPressed,
            child: SizedBox(
              child: Column(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: ColorConstant.primaryColor,
                    size: 30,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: onGalleryPressed,
            child: SizedBox(
              child: Column(
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: ColorConstant.primaryColor,
                    size: 30,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: onDeletePressed,
            child: SizedBox(
              child: Column(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: ColorConstant.primaryColor,
                    size: 30,
                  ),
                  Text(
                    'Remove',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
