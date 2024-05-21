import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';

class PickImageBottomSheet {
  static dynamic show({
    required BuildContext context,
    required VoidCallback onCameraPressed,
    required VoidCallback onGalleryPressed,
    required VoidCallback onRemovePressed,
  }) =>
      showModalBottomSheet(
        backgroundColor: ColorConstant.backgroundLight,
        showDragHandle: true,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(DimenConstant.padding),
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
                      CustomIcon(
                        icon: Icons.camera_alt_outlined,
                        size: 30,
                      ),
                      CustomText(
                        text: 'Camera',
                        color: ColorConstant.primary,
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
                      CustomIcon(
                        icon: Icons.image_outlined,
                        size: 30,
                      ),
                      CustomText(
                        text: 'Gallery',
                        color: ColorConstant.primary,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: onRemovePressed,
                child: SizedBox(
                  child: Column(
                    children: [
                      CustomIcon(
                        icon: Icons.delete_outline_rounded,
                        size: 30,
                      ),
                      CustomText(
                        text: 'Remove',
                        color: ColorConstant.error,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
