import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CropImageScreen extends StatefulWidget {
  // File image;
  String imageType;
  CropImageScreen({
    super.key,
    // required this.image,
    required this.imageType,
  });

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  ImageCropper cropper = ImageCropper();
  ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    cropImage();
    super.initState();
  }

  // crop image
  cropImage() async {
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      CroppedFile? croppedImage = await cropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );
      if (croppedImage != null) {
        image = File(croppedImage.path);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          'Crop ${widget.imageType} image',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Center(
          child: image == null
              ? Image.asset(ImageConstant.cover)
              : Image.file(
                  image!,
                ),
        ),
      ),
    );
  }
}
