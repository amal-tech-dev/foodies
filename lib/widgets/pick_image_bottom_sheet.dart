import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';

import '../utils/color_constant.dart';

class PickImageBottomSheet {
  static dynamic showModalSheet({
    required BuildContext context,
    required VoidCallback onCameraPressed,
    required VoidCallback onGalleryPressed,
    required VoidCallback onRemovePressed,
  }) =>
      showModalBottomSheet(
        backgroundColor: ColorConstant.backgroundDark,
        showDragHandle: true,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(
            DimenConstant.padding,
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
                        color: ColorConstant.secondaryDark,
                        size: 30,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.sText,
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
                        color: ColorConstant.secondaryDark,
                        size: 30,
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.sText,
                        ),
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
                      Icon(
                        Icons.delete_outline,
                        color: ColorConstant.secondaryDark,
                        size: 30,
                      ),
                      Text(
                        'Remove',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.sText,
                        ),
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
